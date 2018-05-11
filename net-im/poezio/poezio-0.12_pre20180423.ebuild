# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_4 python3_5 python3_6 )

inherit distutils-r1 git-r3

DESCRIPTION="A free console based XMPP client"

HOMEPAGE="https://poez.io"

SRC_URI=""
EGIT_REPO_URI="https://git.poez.io/poezio.git"
EGIT_COMMIT_ID="a402bcefd387a1cbc848468f467086b2f3924a3d"

LICENSE="ZLIB"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	>=dev-python/slixmpp-1.3.0
	dev-python/aiodns"
