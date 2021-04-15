# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="General-purpose programming language with an emphasis on functional programming"
HOMEPAGE="https://clojure.org/"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/${P}.tar.gz
	https://github.com/clojure/spec.alpha/archive/spec.alpha-0.2.194.tar.gz
	https://github.com/clojure/core.specs.alpha/archive/core.specs.alpha-0.2.56.tar.gz
"

LICENSE="EPL-1.0 Apache-2.0 BSD"
SLOT="$(ver_cut 1-2)"

KEYWORDS="~amd64 ~x86 ~x86-linux"

# Restrict test as broken due to file not found issue and more.
#RESTRICT="!test? ( test )"

# TODO: Why is ant-core a DEPEND?
COMMON_DEPEND="
	dev-java/ant-core:0
"

CLOJURE_SPEC_ALPHA_SLOT="0.2"

RDEPEND="
	${COMMON_DEPEND}
	dev-java/spec-alpha:${CLOJURE_SPEC_ALPHA_SLOT}
	dev-java/core-specs-alpha:${CLOJURE_SPEC_ALPHA_SLOT}
	>=virtual/jre-1.8
"

DEPEND="
	${COMMON_DEPEND}
	>=virtual/jdk-1.8
"

S="${WORKDIR}/${PN}-${P}"

DOCS=( changes.md CONTRIBUTING.md readme.txt )

src_compile() {
	local boostrap_always=true # TODO: Remove this when ready.
	local extra_ant_args=""
	if ! has_version dev-java/spec-alpha:${CLOJURE_SPEC_ALPHA_SLOT} || ! has_version dev-java/core-specs-alpha:${CLOJURE_SPEC_ALPHA_SLOT} || $boostrap_always; then
		#mkdir -p src/clj/clojure/clojure/core/spec  src/clj/clojure/clojure/core/specs || die
		ln -rs ../spec.alpha-spec.alpha-*/src/main/clojure/clojure/spec src/clj/clojure/spec || die "linking spec-alpha failed"
		ln -rs ../core.specs.alpha-core.specs.alpha-*/src/main/clojure/clojure/core/specs src/clj/clojure/core/specs || die "linking core-specs-alpha failed"
	else
		die "fix bootstraping first" # TODO: Remove this when ready.
		extra_ant_args="-Dmaven.compile.classpath=$(java-pkg_getjars --build-only core-specs-alpha-${CLOJURE_SPEC_ALPHA_SLOT},spec-alpha-${CLOJURE_SPEC_ALPHA_SLOT})"
	fi
	eant ${extra_ant_args} \
		 -f build.xml \
		 jar
}

src_test() {
	eant -f build.xml test
}

src_install() {
	java-pkg_newjar "${PN}.jar"
	java-pkg_dolauncher ${PN}-${SLOT} --main clojure.main
	einstalldocs
}
