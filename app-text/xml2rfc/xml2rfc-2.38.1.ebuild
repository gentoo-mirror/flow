# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="generates RFCs and IETF drafts from document source in XML"
HOMEPAGE="https://pypi.python.org/pypi/xml2rfc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	dev-python/pycountry"
