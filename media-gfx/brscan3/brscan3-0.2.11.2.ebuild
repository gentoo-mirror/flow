# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

MY_PV=$(replace_version_separator 3 -) 

DESCRIPTION="Brother scanner driver for brscan3 models"
HOMEPAGE="http://brother.com"
SRC_URI="i386? ( http://www.brother.com/pub/bsc/linux/dlf/${PN}-${MY_PV}.i386.deb )
	amd64? ( http://www.brother.com/pub/bsc/linux/dlf/${PN}-${MY_PV}.amd64.deb )"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz 
	rm -f data.tar.gz
} 


src_install() {
	cp -pPR * "${D}"/ || die "Installing files failed" 
	insinto /etc/udev/rules.d || die "Insinto failed"
	doins ${FILESDIR}/71-brother-brscan3-libsane.rules || die "Inserting udev rule failed"
}

pkg_postinst() {
	${ROOT}/usr/local/Brother/sane/setupSaneScan3 -i
	elog "You need to be in the scanner group in order to use the scanner"
}

pkg_prerm() {
	${ROOT}/usr/local/Brother/sane/setupSaneScan3 -e
}
