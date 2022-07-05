# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A command-line script to create a diff of two HTML files"
HOMEPAGE="https://github.com/cygri/htmldiff"
HTMLDIFF_COMMIT_ID="2df56d928e32f3d2d1e2914c2dd159847006ee80"
SRC_URI="https://github.com/cygri/htmldiff/archive/${HTMLDIFF_COMMIT_ID}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/decode-string-before-handing-to-is_junk.patch"
)

S="${WORKDIR}/${PN}-${HTMLDIFF_COMMIT_ID}"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/boltons-17.1.0[${PYTHON_USEDEP}]
"
