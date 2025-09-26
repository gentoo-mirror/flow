# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="The Reticulum Network Statck"
HOMEPAGE="https://reticulum.network/"
SRC_URI="https://github.com/markqvist/Reticulum/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Reticulum-${PV}"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~arm64"

RDEPEND="
	acct-user/rnsd
	dev-python/cryptography[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest
