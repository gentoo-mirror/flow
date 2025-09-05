# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Manage Linux testing frameworks"
HOMEPAGE="https://github.com/linux-test-project/kirk"

SRC_URI="https://github.com/linux-test-project/kirk/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

src_install() {
	distutils-r1_src_install
	dosym -r /usr/bin/kirk /usr/bin/runltp-ng
}

distutils_enable_tests pytest
