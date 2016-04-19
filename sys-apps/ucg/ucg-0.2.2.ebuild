# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit autotools

DESCRIPTION="A extremely fast grep-like tool specialized for searching source code"
HOMEPAGE="https://gvansickle.github.io/ucg/"
SRC_URI="https://github.com/gvansickle/${PN}/archive/${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}"

DOCS="AUTHORS README.md NEWS.md"

src_prepare() {
	eautoreconf
}
