# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Linux kernel system configuration"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

S="${WORKDIR}"
LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="amd64"

IUSE="+ioscheduler"

src_install() {
	local udev_rulesdir="$(get_udevdir)"/rules.d

	insinto "${udev_rulesdir}"

	if use ioscheduler; then
		newins - 10-io-schedulers.rules <<-EOF
		# Set IO scheduler to bfq if supported.
		# Otherwise stick with the default scheduler.
		ACTION=="add|change", ATTR{queue/scheduler}=="*bfq*", \
								KERNEL=="sd[a-z]|mmcblk[0-9]|nvme[0-9]n[0-9]", \
								ATTR{queue/scheduler}="bfq"
		EOF
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
