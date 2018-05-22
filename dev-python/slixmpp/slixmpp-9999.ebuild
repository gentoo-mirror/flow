# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3{_4,_5} )

inherit eutils distutils-r1

if [[ $PV = 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/mathieui/slixmpp.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/poezio/slixmpp/archive/slix-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Python library for XMPP - asyncio fork"
HOMEPAGE="https://dev.louiz.org/projects/slixmpp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

S="${WORKDIR}/${P}"

python_test() {
	esetup.py test
}
