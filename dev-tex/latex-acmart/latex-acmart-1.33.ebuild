# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 latex-package

DESCRIPTION="ACM consolidated LaTeX styles"
HOMEPAGE="https://www.acm.org/publications/proceedings-template https://github.com/borisveytsman/acmart"
SRC_URI=""
EGIT_REPO_URI="https://github.com/borisveytsman/acmart.git"
EGIT_COMMIT="0288c5d9b708f52eea6bcf252633ffdc212de438"

LICENSE="LPPL-1.3c"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

DEPEND="dev-texlive/texlive-latex"
RDEPEND="dev-tex/xcolor"

src_compile() {
	emake acmart.cls

	if use doc ; then
		emake acmguide.pdf
	fi

	if use examples ; then
		emake all
	fi
}

src_install() {
	latex-package_src_doinstall cls bst pdf

	dodoc README
}
