# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="python implementation of axolotl encryption"
HOMEPAGE="https://github.com/tgalal/python-axolotl"
SRC_URI="https://github.com/tgalal/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/protobuf-python
		dev-python/pycrypto
		dev-python/python-axolotl-curve25519"
RDEPEND="${DEPEND}"
