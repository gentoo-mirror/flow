# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 systemd

DESCRIPTION="Tools to aid administering Gentoo systems, like silent automatic updates"
HOMEPAGE="https://github.com/Flowdalic/gentools"
EGIT_REPO_URI="https://github.com/Flowdalic/gentools.git"
LICENSE="GPL-3"

SLOT="0"

RDEPEND="
	app-admin/eclean-kernel
	app-portage/eix
	app-portage/gentoolkit
	sys-devel/bc
"

src_install() {
	dosbin update-system

	systemd_dounit update-system.{service,timer}
}
