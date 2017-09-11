# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 java-pkg-2 user

DESCRIPTION="An bot written in Scala using Smack"
HOMEPAGE="https://gitlab.com/Flow/FrankenBot"

EGIT_REPO_URI="https://gitlab.com/Flow/FrankenBot.git"

LICENSE="GPL-3"
SLOT="$PV"
KEYWORDS=""
IUSE=""

DEPEND="|| (
			dev-java/sbt
			dev-java/sbt-bin
		)
		>=virtual/jdk-1.8"
RDEPEND="${DEPEND}
	app-eselect/eselect-frankenbot
	|| (
		>=virtual/jdk-1.8
		>=virtual/jre-1.8
	)"

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

	local frankenbotJar=target/scala-2.11/FrankenBot-assembly-0.1.jar
	local slottedName="${PN}-${SLOT}"
	java-pkg_newjar "${frankenbotJar}" "${slottedName}.jar"
	java-pkg_dolauncher "${slottedName}"
}
