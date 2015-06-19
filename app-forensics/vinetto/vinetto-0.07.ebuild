# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils

MY_P="${PN}-beta-${PV}"
DESCRIPTION="Vinetto is a forensics tool to examine Thumbs.db files."
HOMEPAGE="http://vinetto.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DOCS="README"

RESTRICT="mirror"

DEPEND=""
RDEPEND="dev-lang/python"

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
