# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator

MY_PV=$(replace_version_separator 3 -)
DESCRIPTION="Brother scanner driver for brscan3 models"
HOMEPAGE="http://brother.com"
SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/${PN}-${MY_PV}.amd64.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f data.tar.gz
}

src_install() {
	cp -pPR usr "${D}"/ || die "Installing files failed"
}

pkg_postinst() {
	${ROOT}/usr/local/Brother/sane/setupSaneScan3 -i
	elog "You need to be in the scanner group in order to use the scanner"
}

pkg_prerm() {
	${ROOT}/usr/local/Brother/sane/setupSaneScan3 -e
}
