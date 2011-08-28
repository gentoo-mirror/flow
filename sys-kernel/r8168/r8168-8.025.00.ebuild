# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit linux-mod

DESCRIPTION="r8168 driver for Realtek 8111/8168 PCI-E NICs"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="http://r8168.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

BUILD_PARAMS="KVER=${KV}"
BUILD_TARGETS="modules"

MODULE_NAMES="r8168(net:${S}:${S}/src)"

CONFIG_CHECK="!R8169"
ERROR_R8169="${P} requires Realtek 8169 PCI Gigabit Ethernet adapter (CONFIG_R8169) to be DISABLED"

src_install() {
	dodoc README
	linux-mod_src_install
}