# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 eutils readme.gentoo

DESCRIPTION="Rope in Emacs"
HOMEPAGE="http://rope.sourceforge.net/ropemacs.html
	http://pypi.python.org/pypi/ropemacs"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/rope
	dev-python/ropemode"
RDEPEND="${DEPEND}"

DOCS=( README.txt CONTRIBUTORS docs/ropemacs.txt docs/todo.txt )

src_install() {
	distutils-r1_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
