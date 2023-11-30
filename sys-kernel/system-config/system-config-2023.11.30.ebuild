# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Linux kernel system configuration"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

KEYWORDS="amd64"

IUSE="+ioscheduler"

LICENSE="GPL-3+"
SLOT="0"

S="${WORKDIR}"

src_install() {
	local udev_rulesdir="$(get_udevdir)"/rules.d

	insinto "${udev_rulesdir}"

	if use ioscheduler; then
		newins - 10-ioschedulers.rules <<-EOF
		# HDD
		ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"

		# SSD
		ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"

		# NVMe SSD
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
		EOF
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
