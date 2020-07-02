# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Broadcom Bluetooth firmware"
HOMEPAGE="https://github.com/winterheart/broadcom-bt-firmware"
SRC_URI="https://github.com/winterheart/${PN}/archive/v${PV}.tar.gz"
LICENSE=""

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="${DEPEND}"

src_install() {
	insinto /lib/firmware
	doins -r brcm
}
