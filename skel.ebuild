# Copyright 1999-2011 Gentoo Foundation
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

#src_install() {
#}
