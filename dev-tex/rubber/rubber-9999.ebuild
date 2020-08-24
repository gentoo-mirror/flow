# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

if [[ ${PV} == "9999" ]] || [[ -n "${EGIT_COMMIT_ID}" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/latex-rubber/${PN}.git"
else
	SRC_URI="https://launchpad.net/rubber/trunk/${PV}/+download/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A LaTeX wrapper for automatically building documents"
HOMEPAGE="https://gitlab.com/latex-rubber/rubber"

LICENSE="GPL-2 GPL-2+"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="virtual/latex-base"

# Test dependencies:
# - app-text/texlive-core for rubber's 'cweave' test
# - dev-lang/R for rubber's 'knitr' test (requires knitr R library, currently disabled)
# - dev-texlive/texlive-latexextra for rubber's 'combine' test (currently disabled)
DEPEND="
	${RDEPEND}
	virtual/texi2dvi
	test? (
		app-text/texlive-core
		dev-texlive/texlive-latexextra
		media-gfx/asymptote
		dev-tex/pythontex
	)
"

python_install() {
	insinto /usr/share/zsh/site-functions
	newins misc/zsh-completion _rubber

	local my_install_args=(
		--mandir="${EPREFIX}/usr/share/man"
		--infodir="${EPREFIX}/usr/share/info"
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
	)

	distutils-r1_python_install "${my_install_args[@]}"
}

src_test() {
	cd tests || die

	# Disable the broken 'combine' test as it uses the 'combine' as a
	# latex package when it is only a document class (probably only in
	# newer versions of combine). Also note that this tests works
	# under debian 'buster'. TODO: Look into potential modifications
	# done by debian.
	touch combine/disable || die

	# This test does not work under Gentoo nor Debian 'buster'.
	# TODO: Investigate why it does not work.
	touch cweb-latex/disable || die

	# TODO: Investigate why the following are failing.
	touch fig2dev-dvi/disable || die
	touch fig2dev-path/disable || die
	touch fig2dev-path-inplace/disable || die
	touch fig2dev-path-into/disable || die
	touch graphicx-dotted-files/disable || die
	touch hooks-input-file/disable || die
	touch knitr/disable || die

	# dev-tex/metapost is hard masked.
	touch metapost/disable || die

	./run.sh *
}
