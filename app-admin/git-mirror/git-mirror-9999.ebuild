# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Automatic mirroring of git repositories"
HOMEPAGE="https://gitlab.gentoo.org/flow/git-mirror"

if [[ "${PV}" == "9999" ]] || [[ -n "${EGIT_COMMIT_ID}" ]]; then
	EGIT_REPO_URI="https://gitlab.gentoo.org/flow/git-mirror.git"
	inherit git-r3
else
	SRC_URI="https://gitlab.gentoo.org/flow/${PN}/-/archive/${PV}/${PN}-${PV}.tar.bz2"
	KEYWORDS="amd64"
fi

LICENSE="GPL-3"

SLOT="0"

RDEPEND="
	dev-vcs/git
"

src_compile() {
	:
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}" \
		SYSTEMD_SYSTEM_UNIT_DIR=$(systemd_get_systemunitdir) \
		install
}
