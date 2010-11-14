# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Pdfgrep is a tool to search text in PDF files. It works similar to grep"
HOMEPAGE="http://pdfgrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/poppler"
	RDEPEND="${DEPEND}"

src_install() {
	dodoc README AUTHORS NEWS || die 
	emake DESTDIR="${D}" install || die "emake install failed."
}