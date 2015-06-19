# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools git-2

DESCRIPTION="A tool similar to grep which searches text in PDFs"
HOMEPAGE="http://pdfgrep.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="https://gitlab.com/pdfgrep/pdfgrep.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="unac"

RDEPEND="app-text/poppler
	unac? ( app-text/unac )"
DEPEND="${RDEPEND}
	app-text/asciidoc
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README TODO"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_with unac)
}
