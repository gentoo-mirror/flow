# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A comprehensive guide to the theory and practice of monadic programming in Haskell"
HOMEPAGE="http://monads.haskell.cz/"
SRC_URI="http://monads.haskell.cz/monad_tutorial.tgz"

DEPEND=""
RDEPEND=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"

S="${WORKDIR}"

src_install() {
	dohtml -r monads
}