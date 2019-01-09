# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/pdfgrep/pdfgrep.git"
	inherit autotools git-r3
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://www.pdfgrep.org/download/${P}.tar.gz"
fi

DESCRIPTION="A tool similar to grep which searches text in PDFs"
HOMEPAGE="http://pdfgrep.org/"

SLOT="0"
LICENSE="GPL-2"
IUSE="+pcre test unac"

RDEPEND="
	app-text/poppler:=[cxx]
	dev-libs/libgcrypt:0=
	pcre? ( dev-libs/libpcre[cxx] )
	unac? ( app-text/unac )"
DEPEND="${RDEPEND}
	app-text/asciidoc
	virtual/pkgconfig
	test? (
			dev-texlive/texlive-latex
			dev-texlive/texlive-latexrecommended
			dev-util/dejagnu
		)"

if [[ ${PV} == 9999 ]]; then
	DOCS="AUTHORS README.asciidoc NEWS TODO"

	src_prepare() {
		eautoreconf
	}
fi

src_configure() {
	econf \
		$(use_with pcre libpcre) \
		$(use_with unac)
}
