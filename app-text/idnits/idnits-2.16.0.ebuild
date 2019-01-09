# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tool to check internet-drafts for submission nits"
HOMEPAGE="https://tools.ietf.org/tools/idnits/"
SRC_URI="https://tools.ietf.org/tools/${PN}/${P}.tgz"
LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

RESTRICT="mirror"

DEPEND=""

RDEPEND="
	app-shells/bash
	sys-apps/coreutils
	virtual/awk
"

src_install() {
	dobin idnits
	dodoc about changelog todo
}
