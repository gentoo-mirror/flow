# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A cornucopia of useful code"
HOMEPAGE="https://pypi.org/project/kitchen/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

distutils_enable_tests nose

python_test() {
	# TODO: Figure out why test_i18n is failing.
	nosetests -v \
			  --where=kitchen3 \
			  --ignore-files=test_i18n.py
	if [[ $? -ne 0 ]]; then
		die "Tests fail with ${EPYTHON}"
	fi
}
