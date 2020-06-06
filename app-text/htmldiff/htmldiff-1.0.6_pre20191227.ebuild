# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

inherit distutils-r1 git-r3

DESCRIPTION="A command-line script to create a diff of two HTML files"

HOMEPAGE="https://github.com/cygri/htmldiff"

EGIT_REPO_URI="https://github.com/cygri/htmldiff.git"
EGIT_COMMIT_ID="d68d0c062f2ca0b8df9d11b91266564bcc7b5e9f"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="
	dev-python/six
	>=dev-python/boltons-17.1.0
"
