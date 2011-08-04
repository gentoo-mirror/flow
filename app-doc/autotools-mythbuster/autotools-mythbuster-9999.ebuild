# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git

DESCRIPTION="Autotools Mythbuster (the guide) is a work in progress “book” about autoconf, automake, libtool."
HOMEPAGE="http://www.flameeyes.eu/autotools-mythbuster"
SRC_URI=""
EGIT_REPO_URI="git://gitorious.org/autotools-mythbuster/to-be-published.git"

LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND=""

src_install() {
	dohtml -r public/
}