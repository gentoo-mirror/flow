# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1 git-r3

DESCRIPTION="A LaTeX wrapper for automatically building documents"
HOMEPAGE="https://launchpad.net/rubber/"
EGIT_REPO_URI="https://git.launchpad.net/rubber"
EGIT_COMMIT="69fda79aa76b047ce20935bc22f4c13c69c71bdf"
KEYWORDS="~amd64 ~ppc ~x86"

LICENSE="GPL-2 GPL-2+"
SLOT="0"

RDEPEND="virtual/latex-base"
DEPEND="${RDEPEND}
	virtual/texi2dvi"

PATCHES=(
	"${FILESDIR}/0001-setup.py-package_data-must-be-a-mapping-from-name-to.patch"
)

python_install() {
	local my_install_args=(
		--mandir="${EPREFIX}/usr/share/man"
		--infodir="${EPREFIX}/usr/share/info"
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
	)

	distutils-r1_python_install "${my_install_args[@]}"
}
