# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Broadcom Bluetooth firmware"
HOMEPAGE="https://github.com/winterheart/broadcom-bt-firmware"
SRC_URI=""
EGIT_REPO_URI="https://github.com/winterheart/broadcom-bt-firmware.git"
EGIT_COMMIT="c0bd928b8ae5754b6077c99afe6ef5c949a58f32"
LICENSE=""

SLOT="0"

KEYWORDS="amd64 x86"

IUSE=""

RDEPEND="${DEPEND}"

src_install() {
	insinto /lib/firmware
	doins -r brcm
}
