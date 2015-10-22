# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit autotools git-2

DESCRIPTION="A tool similar to grep which searches text in PDFs"
HOMEPAGE="http://pdfgrep.org/"
SRC_URI=""
EGIT_REPO_URI="https://gitlab.com/pdfgrep/pdfgrep.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="+pcre test unac"

RDEPEND="app-text/poppler:=[cxx]
	pcre? ( dev-libs/libpcre[cxx] )
	unac? ( app-text/unac )"
DEPEND="${RDEPEND}
	app-text/asciidoc
	virtual/pkgconfig
	test? (
			dev-texlive/texlive-latex
			dev-util/dejagnu
		)"

DOCS="AUTHORS NEWS README TODO"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_with pcre) \
		$(use_with unac)
}
