# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.14.1-r2.ebuild,v 1.8 2011/03/29 12:43:44 jer Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit distutils python mercurial

DESCRIPTION="Python library to use Jabber/XMPP networks in a non-blocking way"
HOMEPAGE="http://python-nbxmpp.gajim.org/"
EHG_REPO_URI="http://hg.gajim.org/python-nbxmpp/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_postinst() {
	python_mod_optimize ${PN#python-}
}

pkg_postrm() {
	python_mod_cleanup ${PN#python-}
}
