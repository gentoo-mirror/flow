# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="CLI to interact with Scala"
HOMEPAGE="https://scala-cli.virtuslab.org/"
SRC_URI="
	amd64? ( https://github.com/VirtusLab/scala-cli/releases/download/v${PV}/scala-cli-x86_64-pc-linux.gz -> scala-cli-amd64-${PV}.gz )
	arm64? ( https://github.com/VirtusLab/scala-cli/releases/download/v${PV}/scala-cli-aarch64-pc-linux.gz -> scala-cli-arm64-${PV}.gz )
"

KEYWORDS="~amd64 ~arm64 -*"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}"

RDEPEND="sys-libs/zlib"

QA_TEXTRELS="*"
QA_FLAGS_IGNORED="/usr/bin/scala-cli"

src_prepare() {
	default
	if use amd64; then
		mv scala-cli-amd64-${PV} scala-cli || die
	elif use arm64; then
		mv scala-cli-arm64-${PV} scala-cli || die
	else
		die
	fi
	chmod +x scala-cli || die
}

src_compile() {
	for shell in bash zsh; do
		./scala-cli install-completions \
					--home "${T}" \
					--shell ${shell} \
					--env \
					--output "${S}" \
					> ${shell}-completion || die
	done
}

src_install() {
	dobin scala-cli

	newbashcomp bash-completion scala-cli

	insinto /usr/share/zsh/site-functions
	doins zsh/_scala-cli
}
