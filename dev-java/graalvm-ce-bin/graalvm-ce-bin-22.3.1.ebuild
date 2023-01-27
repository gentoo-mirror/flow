# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A high-performance Java Development Kit (JDK) distribution"
HOMEPAGE="https://www.graalvm.org/"
SRC_URI="https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${PV}/graalvm-ce-java19-linux-amd64-${PV}.tar.gz"

LICENSE="GPL-2-with-classpath-exception"
SLOT="0"
KEYWORDS="~amd64"

MY_PN=${PN%%-bin}
S="${WORKDIR}/${MY_P}"

QA_TEXTRELS="*"

RDEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
"

src_compile() {
	:
}

src_install() {
	insinto opt/${P}
	doins -r .
}
