# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="python implementation of axolotl encryption"
HOMEPAGE="https://github.com/tgalal/python-axolotl"
SRC_URI="https://github.com/tgalal/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/protobuf-2.6[python]
		dev-python/pycrypto
		dev-python/python-axolotl-curve25519"
RDEPEND="${DEPEND}"
