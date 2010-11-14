# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Grep for PDF files"
HOMEPAGE="http://pdfgrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"

RDEPEND="app-text/poppler"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
