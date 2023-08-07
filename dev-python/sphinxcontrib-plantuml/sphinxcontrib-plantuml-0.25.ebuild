# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1

DESCRIPTION="Sphinx extensions for PlantUML"
HOMEPAGE="https://github.com/sphinx-contrib/plantuml/"
SRC_URI="
	https://github.com/sphinx-contrib/plantuml/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${P#sphinxcontrib-}"

RDEPEND="
	test? (
		  dev-python/sphinxcontrib-applehelp[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc

python_compile() {
	distutils-r1_python_compile
	#find "${BUILD_DIR}" -name '*.pth' -delete || die
}

python_test() {
	#distutils_write_namespace sphinxcontrib
	epytest
}
