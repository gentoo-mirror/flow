# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit autotools git-2

DESCRIPTION="A tool similar to grep which searches text in PDFs"
HOMEPAGE="http://pdfgrep.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="git://gitorious.org/pdfgrep/pdfgrep.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="zsh-completion"

RDEPEND="app-text/poppler
	zsh-completion? ( app-shells/zsh )"
DEPEND="${RDEPEND}
	app-text/asciidoc
	dev-util/pkgconfig"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS COPYING HACKING INSTALL NEWS README TODO

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins completion/_pdfgrep
	fi
}
