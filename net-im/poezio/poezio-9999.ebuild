# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_4 python3_5 python3_6 )

inherit distutils-r1 git-r3

DESCRIPTION="A free console based XMPP client"

HOMEPAGE="https://poez.io"

SRC_URI=""
EGIT_REPO_URI="https://git.poez.io/poezio.git"

LICENSE="ZLIB"

SLOT="0"

KEYWORDS=""

IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	>=dev-python/slixmpp-1.3.0
	dev-python/aiodns"
