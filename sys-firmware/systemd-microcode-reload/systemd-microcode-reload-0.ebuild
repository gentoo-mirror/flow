# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Reload microcode on system boot via systemd tmpfiles"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
KEYWORDS="amd64 x86"

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

S="${WORKDIR}"

src_install() {
	systemd_dotmpfilesd "${FILESDIR}/linux-firmware.conf"
}

pkg_postinst() {
	systemd_tmpfiles_create linux-firmware.conf
}
