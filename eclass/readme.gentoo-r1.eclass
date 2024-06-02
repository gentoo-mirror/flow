# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: readme.gentoo-r1.eclass
# @MAINTAINER:
# Pacho Ramos <pacho@gentoo.org>
# @AUTHOR:
# Author: Pacho Ramos <pacho@gentoo.org>
# @SUPPORTED_EAPIS: 6 7 8
# @BLURB: install a doc file shown via elog messages
# @DESCRIPTION:
# An eclass for installing a README.gentoo doc file recording tips
# shown via elog messages. With this eclass, those elog messages will only be
# shown at first package installation and a file for later reviewing will be
# installed under /usr/share/doc/${PF}
#
# @CODE
# inherit readme.gentoo-r1
#
# src_install() {
#   …
#   readme.gentoo_stdin <<-EOF
#   This is the content of the created readme doc file.
#   EOF
#   …
#   if use foo; then
#     readme.gentoo_stdin --apend <<-EOF
#     This is conditional readme content, based on USE=foo.
#     EOF
#   fi
# }
# @CODE
#
# You need to call readme.gentoo_create_doc in src_install phase if you
# use DOC_CONTENTS or obtain the readme from FILESIDR.
#
# Note that this eclass exports pkg_preinst and pkg_postinst functions.

if [[ -z ${_README_GENTOO_ECLASS} ]]; then
_README_GENTOO_ECLASS=1

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

# @ECLASS_VARIABLE: DOC_CONTENTS
# @DEFAULT_UNSET
# @DESCRIPTION:
# The information that is used to create the README.gentoo file.

# @ECLASS_VARIABLE: DISABLE_AUTOFORMATTING
# @DEFAULT_UNSET
# @DESCRIPTION:
# If non-empty, DOC_CONTENTS information will be strictly respected,
# not getting it automatically formatted by fmt. If empty, it will
# rely on fmt for formatting and 'echo -e' options to tweak lines a bit.

# @ECLASS_VARIABLE: FORCE_PRINT_ELOG
# @DEFAULT_UNSET
# @DESCRIPTION:
# If non-empty this variable forces elog messages to be printed.

# @ECLASS_VARIABLE: README_GENTOO_SUFFIX
# @DESCRIPTION:
# If you want to specify a suffix for README.gentoo file please export it.
: "${README_GENTOO_SUFFIX:=""}"

_GREADME_FILENAME="README.gentoo"
_GREADME_HASH_FILENAME=".${_GREADME_FILENAME}.hash"

_GREADME_TMP_FILE="${T}/${_GREADME_FILENAME}"

_GREADME_DOC_DIR="usr/share/doc/${PF}"
_GREADME_REL_PATH="${_GREADME_DOC_DIR}/${_GREADME_FILENAME}"
_GREADME_HASH_REL_PATH="${_GREADME_DOC_DIR}/${_GREADME_HASH_FILENAME}"

# @FUNCTION: readme.gentoo_stdin
# @USAGE: [--append]
# @DESCRIPTION:
# Create the readme doc via stdin.  You can use --append to append to an
# existing readme doc.
readme.gentoo_stdin() {
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

	readme.gentoo_create_doc
}

# @FUNCTION: readme.gentoo_file
# @USAGE: <file>
# @DESCRIPTION:
# Installs the provided file as readme doc.
readme.gentoo_file() {
	debug-print-function ${FUNCNAME} "${@}"

	local input_doc_file="${1}"
	if [[ -z "${input_doc_file}" ]]; then
		die "No file specified"
	fi

	if [[ -f "${_GREADME_TMP_FILE}" ]]; then
		die "Gentoo README already exists"
	fi

	cp "${input_doc_file}" "${_GREADME_TMP_FILE}" || die "Failed to copy ${input_doc_file}"

	readme.gentoo_create_doc
}

# @FUNCTION: readme.gentoo_create_doc
# @DESCRIPTION:
# Create doc file with ${DOC_CONTENTS} variable (preferred) and, if not set,
# look for "${FILESDIR}/README.gentoo" contents. You can use
# ${FILESDIR}/README.gentoo-${SLOT} also.
# Usually called at src_install phase.
readme.gentoo_create_doc() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ -n "${DOC_CONTENTS}" ]]; then
		if [[ -n "${DISABLE_AUTOFORMATTING}" ]]; then
			echo "${DOC_CONTENTS}" > "${_GREADME_TMP_FILE}" || die
		else
			local saved_flags=$-
			set -f				# disable filename expansion in echo arguments
			echo -e ${DOC_CONTENTS} | fold -s -w 70 \
				| sed 's/[[:space:]]*$//' > "${_GREADME_TMP_FILE}"
			assert
			set +f -${saved_flags}
		fi
	elif [[ -f "${FILESDIR}/README.gentoo-${SLOT%/*}" ]]; then
		cp "${FILESDIR}/README.gentoo-${SLOT%/*}" "${_GREADME_TMP_FILE}" || die
	elif [[ -f "${FILESDIR}/README.gentoo${README_GENTOO_SUFFIX}" ]]; then
		cp "${FILESDIR}/README.gentoo${README_GENTOO_SUFFIX}" "${_GREADME_TMP_FILE}" || die
	elif [[ ! -f "${_GREADME_TMP_FILE}" ]]; then
		die "You are not specifying README.gentoo contents!"
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

# @FUNCTION: readme.gentoo_print_elog
# @DESCRIPTION:
# Print elog messages with "${T}"/README.gentoo contents. They will be
# shown only when package is installed at first time.
# Usually called at pkg_postinst phase.
#
# If you want to show them always, please set FORCE_PRINT_ELOG to a non empty
# value in your ebuild before this function is called.
# This can be useful when, for example, DOC_CONTENTS is modified, then, you can
# rely on specific REPLACING_VERSIONS handling in your ebuild to print messages
# when people update from versions still providing old message.
readme.gentoo_print_elog() {
	debug-print-function ${FUNCNAME} "${@}"

	if ! [[ -n "${REPLACING_VERSIONS}" ]] || [[ -n "${FORCE_PRINT_ELOG}" ]]; then
		_GREADME_SHOW="force"
		readme.gentoo-r1_pkg_postinst
	fi
}

# @FUNCTION: readme.gentoo_pkg_preinst
# @DESCRIPTION:
# Performs checks like comparing the readme doc from the image with a
# potentially existing one in the live system.
readme.gentoo-r1_pkg_preinst() {
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

# @FUNCTION: readme.gentoo_pkg_postinst
# @DESCRIPTION:
# Conditionally shows the contents of the readme doc via elog.
readme.gentoo-r1_pkg_postinst() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ ! -v _GREADME_SHOW ]]; then
		ewarn "_GREADME_SHOW not set. Missing call of greadme_pkg_preinst?"
		return
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
