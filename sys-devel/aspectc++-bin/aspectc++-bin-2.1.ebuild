# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="A set of C++ language extensions for aspect-oriented programming with C/C++"
HOMEPAGE="http://www.aspectc.org"
SRC_URI="x86? ( http://aspectc.org/releases/${PV}/ac-bin-linux-x86-${PV}.tar.gz )
	amd64? ( http://aspectc.org/releases/${PV}/ac-bin-linux-x86-64bit-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RESTRICT="mirror"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN%-bin}"

src_prepare() {
	default_src_prepare
	rm Makefile || die
}

src_install() {
	dobin ac++ ag++
}
