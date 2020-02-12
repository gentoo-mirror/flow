# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit latex-package

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/borisveytsman/acmart.git"
else
	SRC_URI="https://github.com/borisveytsman/acmart/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="ACM consolidated LaTeX styles"
HOMEPAGE="https://www.acm.org/publications/proceedings-template https://github.com/borisveytsman/acmart"

LICENSE="LPPL-1.3c"
SLOT="0"
KEYWORDS=""
IUSE="doc examples"

BDEPEND="dev-texlive/texlive-latex"
RDEPEND=""

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
