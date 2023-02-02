# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="CLI to interact with Scala"
HOMEPAGE="https://scala-cli.virtuslab.org/"
SRC_URI="
	amd64? ( https://github.com/VirtusLab/${PN}/releases/download/v${PV}/${PN}-x86_64-pc-linux.gz -> ${PN}-amd64-${PV}.gz )
"

KEYWORDS="~amd64 -*"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}"

RDEPEND="sys-libs/zlib"

QA_TEXTRELS="*"
QA_FLAGS_IGNORED="/usr/bin/scala-cli"

src_prepare() {
	default
	mv scala-cli-amd64-${PV} scala-cli || die
	chmod +x scala-cli || die
}

src_compile() {
	for shell in bash zsh; do
		./scala-cli install-completions \
					--home "${T}" \
					--shell ${shell} \
					--rc-file ${shell}-completion || die
	done
}

src_install() {
	dobin scala-cli

	newbashcomp bash-completion ${PN}

	insinto /usr/share/zsh/site-functions
	newins zsh-completion ${PN}
}
