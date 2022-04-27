# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 systemd

DESCRIPTION="A Scala build server and CLI"
HOMEPAGE="https://scalacenter.github.io/bloop/"
SRC_URI="
	https://github.com/scalacenter/bloop/releases/download/v1.5.0/bloop-x86_64-pc-linux -> ${P}
	https://github.com/scalacenter/bloop/releases/download/v1.5.0/bash-completions -> ${P}-bash-completions
	https://github.com/scalacenter/bloop/releases/download/v1.5.0/fish-completions -> ${P}-fish-completions
	https://github.com/scalacenter/bloop/releases/download/v1.5.0/zsh-completions -> ${P}-zsh-completions
"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}"

RDEPEND="sys-libs/zlib"

QA_FLAGS_IGNORED="usr/bin/bloop"
QA_TEXTRELS="usr/bin/bloop"

src_unpack() {
	:
}

src_install() {
	newbin "${DISTDIR}"/${P} bloop

	systemd_douserunit "${FILESDIR}"/bloop.service

	newbashcomp "${DISTDIR}"/${P}-bash-completions bloop

	insinto /usr/share/fish/vendor_completions.d
	newins "${DISTDIR}"/${P}-fish-completions bloop.fish

	insinto /usr/share/zsh/site-functions
	newins "${DISTDIR}"/${P}-zsh-completions _bloop
}
