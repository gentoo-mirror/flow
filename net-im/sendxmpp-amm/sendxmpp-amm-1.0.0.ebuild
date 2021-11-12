# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ORIG_PN="${PN%-amm}"

DESCRIPTION="Send XMPP (Jabber) messages via command line"
HOMEPAGE="https://github.com/flowdalic/sendxmpp"
SRC_URI="https://github.com/flowdalic/${ORIG_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

S="${WORKDIR}/${ORIG_PN}-${PV}"

RDEPEND="
	dev-lang/ammonite-repl-bin
	!net-im/sendxmpp
"

src_install() {
	dobin sendxmpp
}
