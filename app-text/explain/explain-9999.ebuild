# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Explain commands using ASCII art "
HOMEPAGE="http://www.uninformativ.de/projects/?q=explain"
SRC_URI=""
EGIT_REPO_URI="git://github.com/vain/explain.git
	https://github.com/vain/explain.git"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python
	${DEPEND}"

S="${WORKDIR}/${P}"

src_install() {
	rm man1/explain.1
	mv man1/explain.py.1 man1/explain.1
	doman man1/explain.1
   
	mv explain.py explain
	dobin explain
}
