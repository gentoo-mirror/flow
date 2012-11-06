# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="*:2.4"

inherit distutils python

DESCRIPTION="Python library for Intel HEX files manipulations"
HOMEPAGE="http://pypi.python.org/pypi/IntelHex/"
SRC_URI="https://launchpad.net/intelhex/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"
