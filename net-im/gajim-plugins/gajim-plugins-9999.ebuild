# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.14.1-r2.ebuild,v 1.8 2011/03/29 12:43:44 jer Exp $

EAPI="2"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite xml"

inherit eutils python versionator mercurial

DESCRIPTION="Plugins for Gajim"
HOMEPAGE="http://www.gajim.org/"
EHG_REPO_URI="http://hg.gajim.org/gajim-plugins"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""


DEPEND=""
RDEPEND=">net-im/gajim-0.14.1-r2"

pkg_setup() {
}

src_prepare() {
}

src_configure() {
}

src_install() {

}

