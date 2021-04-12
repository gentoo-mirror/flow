# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils

MY_PV=$(ver_rs 3 -)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="ISIS language for interpretation and analysis of high resolution X-ray spectra."
HOMEPAGE="http://space.mit.edu/CXC/ISIS/index.html"
SRC_URI="ftp://space.mit.edu/pub/cxc/isis/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sci-libs/pgplot
	sci-libs/cfitsio
"
RDEPEND="
	${DEPEND}
	sys-libs/slang
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		--prefix="${ED}/usr/local" \
		--exec-prefix="${ED}/usr" \
		--datarootdir="${ED}/usr/share"
}

src_install() {
	dodir /usr/local/isis/$(ver_cut 1-3)
	emake -j1 install
}
