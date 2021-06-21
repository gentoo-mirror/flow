# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Utility to extract the boot-image from a bootable iso-image (ported from shsucd)"
HOMEPAGE="https://sites.google.com/site/colimit/"
SRC_URI="https://sites.google.com/site/colimit/isobar.c"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_compile() {
	$(tc-getCC) ${CFLAGS} "${DISTDIR}/isobar.c" -o isobar
}

src_install() {
	dobin isobar
}
