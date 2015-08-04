# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 java-utils-2 user

DESCRIPTION="An XMPP and IRC bot written in Scala"
HOMEPAGE="https://gitlab.com/Flow/SmackBot"

EGIT_REPO_URI="https://gitlab.com/Flow/SmackBot.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="|| (
			dev-java/sbt
			dev-java/sbt-bin
		)"
RDEPEND="${DEPEND}
	>=virtual/jre-1.7"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 "/var/lib/${PN}" ${PN}
}

src_compile() {
	sbt assembly || die "Could not compile and assemble ${PN}"
}

src_install() {
	newinitd "${FILESDIR}/${PN}.initd" $PN
	newconfd "${FILESDIR}/${PN}.confd" $PN

	local smackbotJar=target/scala-2.11/SmackBot-assembly-0.1.jar
	java-pkg_newjar "${smackbotJar}"
	java-pkg_dolauncher
}
