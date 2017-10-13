# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="A command-line script to create a diff of two HTML files"

HOMEPAGE="https://github.com/cygri/htmldiff"

SRC_URI=""
EGIT_REPO_URI="https://github.com/cygri/htmldiff.git"
EGIT_COMMIT_ID="f790c2307b256c13c74fadedd803792e9fcc1124"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"
