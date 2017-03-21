# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_DEPEND="2:2.5"

PYTHON_COMPAT=( python2_7 )

inherit bzr distutils-r1

IUSE=""

MY_P=${PN}-${PV/*_p/}

DESCRIPTION="A LaTeX wrapper for automatically building documents"
HOMEPAGE="https://launchpad.net/rubber/"
SRC_URI=""

EBZR_REPO_URI="lp:${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/latex-base"

S=${WORKDIR}/${P/_p*/}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	# configure script is not created by GNU autoconf
	./configure --prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die
}

src_compile() {
	distutils_src_compile

	cd doc
	emake all
}
