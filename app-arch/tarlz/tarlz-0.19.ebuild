# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="A parallel archiver combining tar and lzip"
HOMEPAGE="https://www.nongnu.org/lzip/tarlz.html"
SRC_URI="http://download.savannah.gnu.org/releases/lzip/${PN}/${P}.tar.lz"
LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="app-arch/lzlib"
DEPEND="
	${RDEPEND}
	$(unpacker_src_uri_depends)
"
