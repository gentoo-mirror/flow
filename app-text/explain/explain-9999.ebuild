# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Explain commands using ASCII art "
HOMEPAGE="http://www.uninformativ.de/projects/?q=explain"
SRC_URI=""
EGIT_REPO_URI="https://www.uninformativ.de/git/explain.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
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
