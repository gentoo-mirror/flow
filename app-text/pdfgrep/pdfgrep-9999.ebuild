# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git

DESCRIPTION="A tool similar to grep which searches text in PDFs"
HOMEPAGE="http://pdfgrep.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="git://gitorious.org/pdfgrep/pdfgrep.git"
EGIT_BOOTSTRAP="autogen.sh"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/poppler"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS || die
}