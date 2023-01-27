# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GRAAL_JAVA_MAJOR_VER=19

DESCRIPTION="A high-performance Java Development Kit (JDK) distribution"
HOMEPAGE="https://www.graalvm.org/"
SRC_URI="https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${PV}/graalvm-ce-java${GRAAL_JAVA_MAJOR_VER}-linux-amd64-${PV}.tar.gz"

LICENSE="GPL-2-with-classpath-exception"
SLOT="0"
KEYWORDS="~amd64"

MY_PN=${PN%%-bin}
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_PN}-java${GRAAL_JAVA_MAJOR_VER}-${PV}"

QA_TEXTRELS="*"
QA_FLAGS_IGNORED="*"

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
	local destdir=opt/${MY_P}
	insinto ${destdir}
	doins -r .
	fperms -R 755 /${destdir}/bin /${destdir}/lib/polyglot/bin /${destdir}/lib/installer/bin
}
