# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

#MY_P
DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
# Add strip here if it's an binary ebuild
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

#S="${WORKDIR}/${P}"


#src_configure() {
#}

#src_compile() {
	#emake || die
#}

# src_install() {
# 	if [[ -f Makefile ]] || [[ -f GNUmakefile]] || [[ -f makefile ]] ; then
# 		emake DESTDIR="${D}" install
# 	fi
#
# 	if ! declare -p DOCS >/dev/null 2>&1 ; then
# 		local d
# 		for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
# 				FAQ CREDITS CHANGELOG ; do
# 			[[ -s "${d}" ]] && dodoc "${d}"
# 		done
# 	# TODO: wrong "declare -a" command...
# 	elif declare -p DOCS | grep -q `^declare -a` ; then
# 		dodoc "${DOCS[@]}"
# 	else
# 		dodoc ${DOCS}
# 	fi
# }
