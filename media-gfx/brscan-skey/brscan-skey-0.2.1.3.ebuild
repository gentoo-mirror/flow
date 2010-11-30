# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

MY_PV=$(replace_version_separator 3 -) 

DESCRIPTION="Brother scan key tool"
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
      cp -pPR * "${D}"/ || die "installing data failed" 
}

pkg_postinst() {
	       ${ROOT}/usr/local/Brother/sane/brscan-skey-0.2.1-3.sh 0
}

pkg_prerm() {
	    ${ROOT}/usr/local/Brother/sane/brscan-skey-0.2.1-3.sh r
}
