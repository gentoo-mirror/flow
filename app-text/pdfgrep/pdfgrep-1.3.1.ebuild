# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A tool similar to grep which searches text in PDFs"
HOMEPAGE="http://pdfgrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="unac zsh-completion"

RDEPEND="app-text/poppler:=[cxx]
	unac? ( app-text/unac )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README TODO"

src_configure() {
	econf $(use_with unac)
}

src_install() {
	default
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins completion/_pdfgrep
	fi
}
