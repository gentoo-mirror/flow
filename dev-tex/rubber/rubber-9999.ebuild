# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.launchpad.net/rubber"
	PATCHES=(
		"${FILESDIR}/0001-setup.py-package_data-must-be-a-mapping-from-name-to.patch"
	)
else
	SRC_URI="https://launchpad.net/rubber/trunk/${PV}/+download/${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~x86"
fi

DESCRIPTION="A LaTeX wrapper for automatically building documents"
HOMEPAGE="https://launchpad.net/rubber/"

LICENSE="GPL-2 GPL-2+"
SLOT="0"

RDEPEND="virtual/latex-base"
DEPEND="${RDEPEND}
	virtual/texi2dvi"

python_install() {
	local my_install_args=(
		--mandir="${EPREFIX}/usr/share/man"
		--infodir="${EPREFIX}/usr/share/info"
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
	)

	distutils-r1_python_install "${my_install_args[@]}"
}
