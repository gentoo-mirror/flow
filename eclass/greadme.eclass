# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: greadme.eclass
# @MAINTAINER:
# Florian Schmaus <flow@gentoo.org>
# @AUTHOR:
# Author: Florian Schmaus <flow@gentoo.org>
# @SUPPORTED_EAPIS: 6 7 8
# @BLURB: install a doc file, that will be conditionally shown via elog messages
# @DESCRIPTION:
# An eclass for installing a README.gentoo doc file recording tips
# shown via elog messages.  With this eclass, those elog messages will only be
# shown at first package installation or if the contents of the file have changed.
# Furthermore, a file for later reviewing will be installed under
# /usr/share/doc/${PF}
#
# This eclass is similar to readme.gentoo-r1.eclass.  The main
# differences are as follows.  Firstly, it also displays the doc file
# contents if they have changed.  Secondly, it provides a convenient API to
# install the doc file via stdin.
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
# You must call greadme_pkg_preinst and greadme_pkg_postinst explicitly, if
# you override the default pkg_preinst or respectively pkg_postinst.

if [[ -z ${_README_GENTOO_ECLASS} ]]; then
_README_GENTOO_ECLASS=1

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

_GREADME_FILENAME="README.gentoo"
_GREADME_HASH_FILENAME=".${_GREADME_FILENAME}.hash"

_GREADME_TMP_FILE="${T}/${_GREADME_FILENAME}"

_GREADME_DOC_DIR="usr/share/doc/${PF}"
_GREADME_REL_PATH="${_GREADME_DOC_DIR}/${_GREADME_FILENAME}"
_GREADME_HASH_REL_PATH="${_GREADME_DOC_DIR}/${_GREADME_HASH_FILENAME}"

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

	if [[ ! -f "${_GREADME_TMP_FILE}" ]]; then
		die "Gentoo README does not exist"
	fi

	# subshell to avoid pollution of calling environment
	(
		insinto "${_GREADME_DOC_DIR}"

		doins "${_GREADME_TMP_FILE}"
		cksum --raw "${_GREADME_TMP_FILE}" | newins - "${_GREADME_HASH_FILENAME}"
		assert
	)

	# Save the readme contents in an variable, so that it can be shown ins pkg_postinst().
	_GREADME_CONTENTS=$(< "${_GREADME_TMP_FILE}")

	# Exclude the 4-byte hash file from compression.
	docompress -x "${_GREADME_HASH_REL_PATH}"
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

	local image_hash_file="${ED}/${_GREADME_HASH_REL_PATH}"

	check_live_doc_file() {
		local cur_pvr=$1
		local live_hash_file="${EROOT}/usr/share/doc/${PN}-${cur_pvr}/${_GREADME_HASH_FILENAME}"

		if [[ ! -f ${live_hash_file} ]]; then
			_GREADME_SHOW="no-current-greadme"
			return
		fi

		cmp -s "${live_hash_file}" "${image_hash_file}"
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
	echo -e "${_GREADME_CONTENTS}" | while read -r line; do elog "${line}"; done
	elog ""
	elog "(Note: Above message is only printed the first time package is"
	elog "installed or if the the message changed. Please look at"
	elog "${EPREFIX}/${_GREADME_REL_PATH} for future reference)"
}

fi

EXPORT_FUNCTIONS pkg_preinst pkg_postinst
