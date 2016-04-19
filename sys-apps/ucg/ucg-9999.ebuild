# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit autotools git-r3

DESCRIPTION="A extremely fast grep-like tool specialized for searching source code"
HOMEPAGE="https://gvansickle.github.io/ucg/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/gvansickle/ucg.git"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}"

DOCS="AUTHORS README.md NEWS.md"

src_prepare() {
	eautoreconf
}
