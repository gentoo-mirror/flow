# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit autotools eutils java-pkg-2 git-r3

JICMP_FULL="${P}-1"

DESCRIPTION="A library to allow the use of raw ICMP packets in Java"
HOMEPAGE="http://www.opennms.org/"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

EGIT_REPO_URI="https://github.com/OpenNMS/jicmp.git"
EGIT_COMMIT_ID="${JICMP_FULL}"

SLOT="0"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

src_prepare() {
	eapply_user
	eautoreconf
}

src_compile() {
	default_src_compile
	if use doc; then
		javadoc -d javadoc $(find src -name "*.java") || die "Javadoc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	use source && java-pkg_dosrc org
	use doc && java-pkg_dojavadoc javadoc
}
