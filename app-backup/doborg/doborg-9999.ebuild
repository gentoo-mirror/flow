# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Tools to aid administering Gentoo systems, like silent automatic updates"
HOMEPAGE="https://gitlab.com/Flow/doborg"
EGIT_REPO_URI="https://gitlab.com/Flow/doborg.git"
LICENSE="GPL-3+"

SLOT="0"

KEYWORDS=""

IUSE=""

RDEPEND="
	app-admin/pwgen
	app-backup/borgbackup
"

src_compile() {
	:
}
