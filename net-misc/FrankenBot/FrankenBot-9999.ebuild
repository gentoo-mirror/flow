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

COMMON_DEPEND="dev-lang/scala:2.12
			   >=virtual/jdk-1.8"
DEPEND="$COMMON_DEPEND
		|| (
			dev-java/sbt
			dev-java/sbt-bin
		)"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-FrankenBot
	|| (
		>=virtual/jdk-1.8
		>=virtual/jre-1.8
	)"

pkg_setup() {
	declare -rl user="${PN}"
	declare -rl group="${user}"
	enewgroup "${group}"
	enewuser "${user}" -1 -1 "/var/lib/${PN}" "${group}"
}

src_compile() {
	sbt assembly || die "Could not compile and assemble ${PN}"
}

src_install() {
	newinitd "${FILESDIR}/${PN}.initd" $PN
	newconfd "${FILESDIR}/${PN}.confd" $PN

	local frankenbotJar=target/scala-2.12/FrankenBot-assembly-0.1.jar
	local slottedName="${PN}-${SLOT}"
	java-pkg_newjar "${frankenbotJar}" "${slottedName}.jar"
	java-pkg_dolauncher "${slottedName}"
}
