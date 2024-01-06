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
#   greadme_stdin <<- EOF
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
#
# TODO:
# - Should this be named README.Distribution instead of README.Gentoo?
#   Would that make things easier for Gentoo derivates?
#   Similary, (g → d)readme, (G → D)README?
# - Incooperate changes into readme.gentoo-r1.elcass?
# - Compressing the readme doc file is probably fragile, as it is not
#   guaranteed that the required binaries for decompression are installed
#   in pkg_preinst/pkg_postinst. Note that it is even possible that two
#   different compression algorithms are used, in case of binpkgs.

if [[ -z ${_README_GENTOO_ECLASS} ]]; then
_README_GENTOO_ECLASS=1

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ${_GREADME_COMPRESS} ]]; then
	inherit unpacker
fi

_GREADME_FILENAME="README.gentoo"
_GREADME_TMP_FILE="${T}/${_GREADME_FILENAME}"
_GREADME_REL_PATH="usr/share/doc/${PF}/${_GREADME_FILENAME}"

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
			die "Gentoo README already exists"
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

	if ! [[ ${_GREADME_COMPRESS} ]]; then
		docompress -x "${_GREADME_REL_PATH}"
	fi

	( # subshell to avoid pollution of calling environment
		docinto .
		dodoc "${_GREADME_TMP_FILE}"
	) || die

}

# @FUNCTION: greadme_pkg_preinst
# @DESCRIPTION:
# Performs checks like comparing the readme doc from the image with a
# potentially existing one in the live system.
greadme_pkg_preinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		_GREADME_SHOW="fresh-install"
		return
	fi

	check_live_doc_file() {
		local cur_pvr=$1
		local live_doc_file="${EROOT}/usr/share/doc/${PN}-${cur_pvr}/${_GREADME_FILENAME}"

		if [[ ${_GREADME_COMPRESS} ]]; then
			local live_doc_files=( $(ls -1 ${live_doc_file}*) )
			case ${#live_doc_files[@]} in
				0)
					_GREADME_SHOW="no-current-greadme"
					return
					;;
				1)
					live_doc_file="${live_doc_files[0]}"
					;;
				*)
					die "unpexpected number of Gentoo README files found"
					;;
			esac

			local image_doc_files=( $(ls -1 ${image_doc_file}*) )
			case ${#image_doc_files[@]} in
				0)
					die "No Gentoo README found in image"
					;;
				1)
					image_doc_file="${image_doc_files[0]}"
					;;
				*)
					die "unpexpected number of Gentoo README files found"
					;;
			esac

			mkdir "${T}/greadme"

			mkdir "${T}/greadme/live"
			pushd "${T}/greadme/live" > /dev/null
			local live_doc_file_basename="$(basename "${live_doc_file}")"
			if [[ "${live_doc_file_basename}" == "${_GREADME_FILENAME}" ]]; then
				cp "${live_doc_file}" .
			else
				unpacker "${live_doc_file}"
			fi
			popd > /dev/null

			mkdir "${T}/greadme/image"
			pushd "${T}/greadme/image" > /dev/null
			local image_doc_file_basename="$(basename "${image_doc_file}")"
			if [[ "${image_doc_file_basename}" == "${_GREADME_FILENAME}" ]]; then
				cp "${image_doc_file}" .
			else
				unpacker "${image_doc_file}"
			fi
			popd > /dev/null

			live_doc_file="${T}/greadme/live/${_GREADME_FILENAME}"
			image_doc_file="${T}/greadme/image/${_GREADME_FILENAME}"
			# Store the unpacked greadme in a global variable so that it can
			# be used in greadme_pkg_postinst.
			_GREADME_UNPACKED="${image_doc_file}"
		else
			if [[ ! -f ${live_doc_file} ]]; then
				_GREADME_SHOW="no-current-greadme"
				return
			fi
		fi

		cmp -s "${live_doc_file}" "${image_doc_file}"
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

	local image_doc_file="${ED}/${_GREADME_REL_PATH}"

	local replaced_version
	for replaced_version in ${REPLACING_VERSIONS}; do
		check_live_doc_file ${replaced_version}
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

	local greadme_path
	if [[ ${_GREADME_COMPRESS} ]]; then
		greadme_path="${_GREADME_UNPACKED}"
	else
		greadme_path="${EROOT}/${_GREADME_REL_PATH}"
	fi

	local greadme_line
	while read -r greadme_line; do elog "${greadme_line}"; done < "${EROOT}/${_GREADME_REL_PATH}"
	elog ""
	elog "(Note: Above message is only printed the first time package is"
	elog "installed or if the the message changed. Please look at"
	elog "${EPREFIX}/${_GREADME_REL_PATH} for future reference)"
}

EXPORT_FUNCTIONS pkg_preinst pkg_postinst

fi
