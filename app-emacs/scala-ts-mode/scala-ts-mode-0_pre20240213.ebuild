# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

MY_COMMIT="88f9ad9d8800515f47609829df9b2a15dc475eff"
DESCRIPTION="Scala Tree-Sitter Mode"
HOMEPAGE="https://github.com/KaranAhlawat/scala-ts-mode"
SRC_URI="
	https://codeload.github.com/KaranAhlawat/scala-ts-mode/tar.gz/${MY_COMMIT}
		-> ${P}.tar.gz
"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-libs/tree-sitter-scala"

DOCS="README.org"

SITEFILE="50${PN}-gentoo.el"
