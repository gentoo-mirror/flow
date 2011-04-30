# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod

DESCRIPTION="Realtek RTL8111B/RTL8168B NIC drivers"
HOMEPAGE="http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=13&PFid=5&Level=5&Conn=4&DownTypeID=3&GetDown=false"
#SRC_URI="mirror://arcon/${P}.tar.bz2"
SRC_URI="ftp://202.65.194.212/cn/nic/${P}.tar.bz2
	 ftp://202.65.194.211/cn/nic/${P}.tar.bz2
	  ftp://210.51.181.211/cn/nic/${P}.tar.bz2"
RESTRICT="mirror"
LICENSE="GPL2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MODULE_NAMES="src/r8168(kernel/drivers/net:${S}:${S})"
BUILD_TARGETS="modules"