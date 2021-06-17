# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="test"

inherit java-pkg-2 java-ant-2

SPEC_ALPHA_VER="0.2.194"
CORE_SPECS_ALPHA_VER="0.2.56"

DESCRIPTION="General-purpose programming language with an emphasis on functional programming"
HOMEPAGE="https://clojure.org/"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/${P}.tar.gz
	https://github.com/clojure/spec.alpha/archive/spec.alpha-${SPEC_ALPHA_VER}.tar.gz
	https://github.com/clojure/core.specs.alpha/archive/core.specs.alpha-${CORE_SPECS_ALPHA_VER}.tar.gz
"

LICENSE="EPL-1.0 Apache-2.0 BSD"
SLOT="$(ver_cut 1-2)"

KEYWORDS="~amd64 ~x86 ~x86-linux"

PATCHES=(
	"${FILESDIR}/add-compile-spec-ant-build-target.patch"
)

# Restrict test as broken due to file not found issue and more.
RESTRICT="!test? ( test )"

CLOJURE_SPEC_ALPHA_SLOT="0.2"

COMMON_DEPEND="
	dev-java/ant-core:0
"

RDEPEND="
	${COMMON_DEPEND}
	>=virtual/jre-1.8
"

DEPEND="
	${COMMON_DEPEND}
	>=virtual/jdk-1.8
"

S="${WORKDIR}/${PN}-${P}"

DOCS=( changes.md CONTRIBUTING.md readme.txt )

src_prepare() {
	default
	java-utils-2_src_prepare

	ln -rs \
	   "../spec.alpha-spec.alpha-${SPEC_ALPHA_VER}/src/main/clojure/clojure/spec" \
	   "src/clj/clojure/spec" || die "Could not create symbolic link for spec-alpha"
	ln -rs \
	   "../core.specs.alpha-core.specs.alpha-${CORE_SPECS_ALPHA_VER}/src/main/clojure/clojure/core/specs" \
	   "src/clj/clojure/core/specs" || die "Could not create symbolic link for core-specs-alpha"
}

src_compile() {
	eant -f build.xml jar
}

src_test() {
	eant -f build.xml test
}

src_install() {
	java-pkg_newjar "${PN}.jar"
	java-pkg_dolauncher ${PN}-${SLOT} --main clojure.main
	einstalldocs
}
