# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3

DESCRIPTION="Enterprise-Grade Open-Source Network Management Platform"

HOMEPAGE="http://www.opennms.org/"

LICENSE="AGPL-3+"

SLOT="0"
KEYWORDS="~amd64 ~x86"

EGIT_REPO_URI="https://github.com/OpenNMS/${PN}.git"
EGIT_COMMIT_ID="${PV}-1"

IUSE=""

RDEPEND="${DEPEND}
	dev-java/jicmp"

src_compile() {
	./compile.pl || die
}

src_install() {
	./assemble.pl -p fulldir || die
}
