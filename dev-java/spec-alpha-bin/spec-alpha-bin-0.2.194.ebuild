# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2

DESCRIPTION="A Clojure library to describe the structure of data and functions"
HOMEPAGE="https://clojure.org/ https://github.com/clojure/spec.alpha"
SRC_URI="https://repo1.maven.org/maven2/org/clojure/spec.alpha/0.2.194/spec.alpha-0.2.194.jar"

LICENSE="EPL-1.0"
SLOT="0.2"
KEYWORDS="~amd64 ~x86 ~x86-linux"

RDEPEND=">=virtual/jre-1.8:*"

S="${WORKDIR}"

src_install() {
	java-pkg_newjar "${DISTDIR}/spec.alpha-0.2.194.jar" spec-alpha-bin
}
