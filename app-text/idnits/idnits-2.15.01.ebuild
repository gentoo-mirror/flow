# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# inherit lists eclasses to inherit functions from. For example, an ebuild
# that needs the eautoreconf function from autotools.eclass won't work
# without the following line:
#inherit autotools

DESCRIPTION="A tool to check internet-drafts for submission nits"
HOMEPAGE="https://tools.ietf.org/tools/idnits/"
SRC_URI="https://tools.ietf.org/tools/${PN}/${P}.tgz"
LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

RESTRICT="mirror"

DEPEND=""

RDEPEND="app-shells/bash"

src_install() {
	dobin idnits
	dodoc about changelog todo
}
