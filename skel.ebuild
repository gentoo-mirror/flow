# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

#MY_P
DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://foo.bar.com/"
SRC_URI="ftp://foo.bar.com/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome X"

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
#RESTRICT="strip"

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
