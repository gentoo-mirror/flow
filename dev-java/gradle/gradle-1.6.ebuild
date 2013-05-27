# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit java-pkg-2

DESCRIPTION="A project automation and build tool similar to Apache Ant and Apache Maven with a Groovy based DSL"
SRC_URI="http://services.gradle.org/distributions/${P}-src.zip"

HOMEPAGE="http://www.gradle.org/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/zip
	app-admin/eselect-gradle"
RDEPEND=">=virtual/jdk-1.5"

#IUSE="doc"

S="${WORKDIR}/${P}"


pkg_preinst() {
	ewarn "This gradle source ebuild is experimental."
	ewarn "Because of the default gradle buld process, it may be possilbe that additinal files are fetched during src_compile"
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	# if use docs; then
	# 	cradle docs
	# fi
	gradle --gradle-user-home ${WORKDIR} install -Pgradle_installPath=dist || die
}

src_install() {
	cd dist || die
	dodoc changelog.txt getting-started.html

	local gradle_home="${EROOT}usr/share/${P}"

	insinto "${gradle_home}"

	# jars
	cd lib
	for jar in *.jar; do
		java-pkg_newjar ${jar} ${jar}
	done

	# plugin jars
	insinto "${gradle_home}/lib/plugins"
	doins plugins/*

	java-pkg_dolauncher "${P}" --main org.gradle.launcher.GradleMain --java_args "-Dgradle.home=${gradle_home} \${GRADLE_OPTS}"
}

pkg_postinst() {
	eselect gradle update ifunset
}

pkg_postrm() {
	eselect gradle update ifunset
}
