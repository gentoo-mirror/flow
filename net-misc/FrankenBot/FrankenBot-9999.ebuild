# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 java-pkg-2

DESCRIPTION="An bot written in Scala using Smack"
HOMEPAGE="https://gitlab.com/Flow/FrankenBot"

EGIT_REPO_URI="https://gitlab.com/Flow/FrankenBot.git"

LICENSE="GPL-3"
SLOT="$PV"
KEYWORDS=""
IUSE=""

BDEPEND="
	acct-user/frankenbot
	>=virtual/jdk-1.8:*
	|| (
		dev-java/sbt
		dev-java/sbt-bin
	)
"
RDEPEND="
	acct-user/frankenbot
	app-eselect/eselect-FrankenBot
	>=virtual/jre-1.8:*
"

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
