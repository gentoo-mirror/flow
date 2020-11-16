# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Scala language-based scripting and REPL"
HOMEPAGE="https://ammonite.io/"
SCALA_VERSION="2.13"
SRC_URI="https://github.com/lihaoyi/Ammonite/releases/download/${PV}/${SCALA_VERSION}-${PV} -> ammonite-${PV}"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE=""

# Ammonite release binaries seem to package also a full scala
# distribution, no need ot depend on dev-lang/scala(-bin).
# RDEPEND="
# 	>=dev-lang/scala-bin-${SCALA_VERSION}
# "

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/ammonite-${PV}" amm || die
}

src_install() {
	dobin amm
}
