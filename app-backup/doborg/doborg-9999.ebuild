# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 systemd

DESCRIPTION="Full-system backup tool based on borg backup"
HOMEPAGE="https://gitlab.com/Flow/doborg"
EGIT_REPO_URI="https://gitlab.com/Flow/doborg.git"
LICENSE="GPL-3+"

SLOT="0"

KEYWORDS=""

IUSE=""

RDEPEND="
	acct-user/doborg
	app-admin/pwgen
	app-backup/borgbackup
	sys-apps/util-linux[caps]
"

src_compile() {
	:
}

src_install() {
	emake \
		DESTDIR="${D}" \
		SYSTEMD_SYSTEM_UNIT_DIR="$(systemd_get_systemunitdir)" \
		install
}
