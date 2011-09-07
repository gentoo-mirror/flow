# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

DESCRIPTION="ISIS programming language is designed to facilitate the interpretation and analysis of high resolution X-ray spectra."
HOMEPAGE="http://space.mit.edu/CXC/ISIS/index.html"
SRC_URI="ftp://space.mit.edu/pub/cxc/isis/isis-1.6.1-43.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
RESTRICT="mirror"

DEPEND="sci-libs/pgplot
	sci-libs/cfitsio"
RDEPEND="${DEPEND}
	 >=sys-libs/slang-2.2.4"

S="${WORKDIR}/isis-1.6.1-43"

src_configure() {
	./configure --prefix=${D}usr/local \
		--exec-prefix=${D}usr \
		--datarootdir=${D}usr/share
}

src_install() {
	dodir /usr/local/isis/1.6.1
	make install
}