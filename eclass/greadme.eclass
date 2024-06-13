# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: greadme.eclass
# @MAINTAINER:
# Florian Schmaus <flow@gentoo.org>
# @AUTHOR:
# Author: Florian Schmaus <flow@gentoo.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: install a doc file, that will be conditionally shown via elog messages
# @DESCRIPTION:
# An eclass for installing a README.gentoo doc file with important
# information for the user.  The content of README.gentoo will shown be
# via elog messages either on fresh installations or if the contents of
# the file have changed.  Furthermore, the README.gentoo file will be
# installed under /usr/share/doc/${PF} for later consultation.
#
# This eclass was inspired by readme.gentoo-r1.eclass.  The main
# differences are as follows.  Firstly, it only displays the doc file
# contents if they have changed (unless GREADME_FORCE_SHOW is set).
# Secondly, it provides a convenient API to install the doc file via
# stdin.
#
# @CODE
# inherit greadme
#
# src_install() {
#   …
#   greadme_stdin <<-EOF
#   This is the content of the created readme doc file.
#   EOF
#   …
#   if use foo; then
#     greadme_stdin --apend <<-EOF
#     This is conditional readme content, based on USE=foo.
#     EOF
#   fi
# }
# @CODE
#
# If the ebuild overrides the default pkg_preinst or respectively
# pkg_postinst, then it must call greadme_pkg_preinst and
# greadme_pkg_postinst explicitly.

if [[ -z ${_GREADME_ECLASS} ]]; then
_GREADME_ECLASS=1

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

_GREADME_FILENAME="README.gentoo"
_GREADME_TMP_FILE="${T}/${_GREADME_FILENAME}"
_GREADME_DOC_DIR="usr/share/doc/${PF}"
_GREADME_REL_PATH="${_GREADME_DOC_DIR}/${_GREADME_FILENAME}"

# @ECLASS_VARIABLE: GREADME_FORCE
# @DEFAULT_UNSET
# @DESCRIPTION:
# If set, then uncondiionally show the contents of the readme file in
# pkg_postinst via elog.

# @FUNCTION: greadme_stdin
# @USAGE: [--append]
# @DESCRIPTION:
# Create the readme doc via stdin.  You can use --append to append to an
# existing readme doc.
greadme_stdin() {
	debug-print-function ${FUNCNAME} "${@}"

	local append=false
	while [[ -n ${1} ]] && [[ ${1} =~ --* ]]; do
		case ${1} in
			--append)
				append=true
				shift
				;;
		esac
	done

	if $append; then
		if [[ ! -f "${_GREADME_TMP_FILE}" ]]; then
			die "Gentoo README does not exist when trying to append to it"
		fi

		cat >> "${_GREADME_TMP_FILE}" || die
	else
		if [[ -f "${_GREADME_TMP_FILE}" ]]; then
			die "Gentoo README already exists while trying to create it"
		fi

		cat > "${_GREADME_TMP_FILE}" || die
	fi

	_greadme_install_doc
}

# @FUNCTION: greadme_file
# @USAGE: <file>
# @DESCRIPTION:
# Installs the provided file as readme doc.
greadme_file() {
	debug-print-function ${FUNCNAME} "${@}"

	local input_doc_file="${1}"
	if [[ -z "${input_doc_file}" ]]; then
		die "No file specified"
	fi

	if [[ -f "${_GREADME_TMP_FILE}" ]]; then
		die "Gentoo README already exists"
	fi

	cp "${input_doc_file}" "${_GREADME_TMP_FILE}" || die

	_greadme_install_doc
}

# @FUNCTION: _greadme_install_doc
# @INTERNAL
# @DESCRIPTION:
# Installs the readme file from the temp directory into the image.
_greadme_install_doc() {
	debug-print-function ${FUNCNAME} "${@}"

	# Subshell to avoid pollution of calling environment.
	(
		insinto "${_GREADME_DOC_DIR}"
		doins "${_GREADME_TMP_FILE}"
	)

	# Exclude the readme file from compression, so that its contents can
	# be easily compared.
	docompress -x "${_GREADME_REL_PATH}"
}

# @FUNCTION: greadme_pkg_preinst
# @DESCRIPTION:
# Performs checks like comparing the readme doc from the image with a
# potentially existing one in the live system.
greadme_pkg_preinst() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		_GREADME_SHOW="fresh-install"
		return
	fi

	if [[ -v GREADME_FORCE_SHOW ]]; then
		_GREADME_SHOW="forced"
		return
	fi

	local image_greadme_file="${ED}/${_GREADME_REL_PATH}"
	if [[ ! -f "${image_greadme_file}" ]]; then
		# No README file was created by the ebuild.
		_GREADME_SHOW=""
		return
	fi

	check_live_doc_file() {
		local cur_pvr=$1
		local live_greadme_file="${EROOT}/usr/share/doc/${PN}-${cur_pvr}/${_GREADME_FILENAME}"

		if [[ ! -f ${live_greadme_file} ]]; then
			_GREADME_SHOW="no-current-greadme"
			return
		fi

		cmp -s "${live_greadme_file}" "${image_greadme_file}"
		local ret=$?
		case ${ret} in
			0)
				_GREADME_SHOW=""
				;;
			1)
				_GREADME_SHOW="content-differs"
				;;
			*)
				die "cmp failed with ${ret}"
				;;
		esac
	}

	local replaced_version
	for replaced_version in ${REPLACING_VERSIONS}; do
		check_live_doc_file ${replaced_version}

		# Once _GREADME_SHOW is non empty, we found a reason to show the
		# readme and we can abort the loop.
		if [[ -n ${_GREADME_SHOW} ]]; then
			break
		fi
	done
}

# @FUNCTION: greadme_pkg_postinst
# @DESCRIPTION:
# Conditionally shows the contents of the readme doc via elog.
greadme_pkg_postinst() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ ! -v _GREADME_SHOW ]]; then
		die "_GREADME_SHOW not set. Did you call greadme_pkg_preinst?"
	fi

	if [[ -z "${_GREADME_SHOW}" ]]; then
		# If _GREADME_SHOW is empty, then there is no reason to show the contents.
		return
	fi

	local line
	while read -r line; do elog "${line}"; done < "${EROOT}/${_GREADME_REL_PATH}"
	elog ""
	elog "(Note: Above message is only printed the first time package is"
	elog "installed or if the the message changed. Please look at"
	elog "${EPREFIX}/${_GREADME_REL_PATH} for future reference)"
}

fi

EXPORT_FUNCTIONS pkg_preinst pkg_postinst
