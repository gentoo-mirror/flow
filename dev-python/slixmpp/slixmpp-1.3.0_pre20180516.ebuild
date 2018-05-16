# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3{_4,_5} )

inherit eutils git-r3 distutils-r1

SRC_URI=""
EGIT_REPO_URI="https://github.com/mathieui/slixmpp.git"
EGIT_COMMIT="d146ce9fb6aec1eae0a1d6671945eb6fa03fabef"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Python library for XMPP - asyncio fork"
HOMEPAGE="https://dev.louiz.org/projects/slixmpp"

LICENSE="MIT"
SLOT="0"
IUSE="crypt cython"

DEPEND=""
RDEPEND="
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]

	crypt? (
		dev-python/python-gnupg[${PYTHON_USEDEP}]
	)
	cython? (
		dev-python/cython[${PYTHON_USEDEP}]
		net-dns/libidn
	)
"

python_test() {
	esetup.py test
}
