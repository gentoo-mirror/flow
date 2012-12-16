# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils git-2

DESCRIPTION="Python X2Go Client (command line client)"
HOMEPAGE="http://www.x2go.org"
SRC_URI=""
EGIT_REPO_URI="git://code.x2go.org/pyhoca-cli.git"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/python-x2go
	sys-apps/man"
RDEPEND="${DEPEND}
	dev-python/setproctitle
	virtual/python-argparse"

src_compile() {
	distutils_src_compile
	make -f Makefile.man2html || die
}

src_install() {
	distutils_src_install
	dobin pyhoca-cli
	doman man/man1/*
}
