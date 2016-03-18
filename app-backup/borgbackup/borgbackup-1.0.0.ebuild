# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python3_4 )

inherit distutils-r1

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/borgbackup/borg.git"
	inherit git-r3
#	S="${WORKDIR}/borg-${PV}/"
else
	SRC_URI="https://github.com/borgbackup/borg/releases/download/${PV}/${P}.tar.gz"
	# -> ${P}.tar.gz"
#	S="${WORKDIR}/${PORGA}-${PV}/"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Deduplicating backup program with compression and authenticated encryption."
HOMEPAGE="https://borgbackup.github.io/"

LICENSE="BSD"
SLOT="0"
IUSE="libressl"

RESTRICT="test"

RDEPEND="dev-python/msgpack[${PYTHON_USEDEP}]
		app-arch/lz4
		dev-python/setuptools_scm[${PYTHON_USEDEP}]
		dev-python/cython
		dev-python/llfuse[${PYTHON_USEDEP}]
		!libressl? ( dev-libs/openssl:0 )
		libressl? ( dev-libs/libressl )"

DEPEND="${RDEPEND}"
