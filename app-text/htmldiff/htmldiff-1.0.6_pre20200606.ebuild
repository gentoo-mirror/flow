# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="A command-line script to create a diff of two HTML files"

HOMEPAGE="https://github.com/cygri/htmldiff"

EGIT_REPO_URI="https://github.com/cygri/htmldiff.git"
EGIT_COMMIT_ID="2df56d928e32f3d2d1e2914c2dd159847006ee80"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

PATCHES=(
	"${FILESDIR}/decode-string-before-handing-to-is_junk.patch"
)

RDEPEND="
	dev-python/six
	>=dev-python/boltons-17.1.0
"
