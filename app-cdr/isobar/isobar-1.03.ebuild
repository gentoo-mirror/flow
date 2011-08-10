# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="This is a Linux port of isobar utility from shsucd. It's able to extract the boot-image from a bootable iso-image."
HOMEPAGE="https://sites.google.com/site/colimit/"
SRC_URI="https://sites.google.com/site/colimit/isobar.c"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

S="${WORKDIR}"

src_prepare() {
	cp ${DISTDIR}/isobar.c ${S}
}

src_compile() {
	gcc ${CFLAGS} isobar.c -o isobar
}

src_install() {
	dobin isobar
}