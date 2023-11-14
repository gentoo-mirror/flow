# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-utils-2 systemd tmpfiles

MY_PN=${PN%-bin}
MY_P=${MY_PN}-${PV}

DESCRIPTION="An autosuspend and wakeup daemon"
HOMEPAGE="https://gitlab.gentoo.org/flow/sandmann"

if [[ "${PV}" == "9999" ]] || [[ -n "${EGIT_COMMIT_ID}" ]]; then
	EGIT_REPO_URI="https://gitlab.gentoo.org/flow/sandmann.git"
	inherit git-r3
else
	SRC_URI="https://dev.gentoo.org/~flow/${MY_PN}/archive/${MY_P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+ LGPL-3"
SLOT="0"

RDEPEND="
	sys-apps/systemd
	sys-auth/polkit
	|| (
		virtual/jre:17
		virtual/jre:21
	)
"
if [[ ! -v EGIT_REPO_URI ]]; then
	S="${WORKDIR}/${MY_P}"
else
	DEPEND="
	|| (
		virtual/jdk:17
		virtual/jdk:21
	)
"
fi

src_prepare() {
	default
	sed -i \
		-e 's|^ExecStart=.*|ExecStart=/usr/bin/sandmann|' \
		sandmann.service || die
}

src_compile() {
	if [[ -v EGIT_REPO_URI ]]; then
		local -x XDG_CACHE_HOME="${T}/cache"
		local -x HOME="${T}"
		emake compile
	fi
}

src_install() {
	local my_emake_args=(
		DESTDIR="${D}"
		SYSTEMD_SYSTEM_UNIT_DIR="$(systemd_get_systemunitdir)"
		TARGET_BINARY=
	)
	if [[ ! -v EGIT_REPO_URI ]]; then
		my_emake_args+=(
			SOURCELESS_INSTALL=true
		)
	fi

	emake ${my_emake_args[@]} install

	java-pkg_newjar out/main/assembly.dest/out.jar sandmann.jar
	java-pkg_dolauncher sandmann
}

pkg_postinst() {
	tmpfiles_process sandmann.conf
}
