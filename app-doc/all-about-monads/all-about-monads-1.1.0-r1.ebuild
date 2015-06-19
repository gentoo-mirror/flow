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

src_prepare() {
	sed -i -e "s:..\/examples\/:\/opt\/${PN}\/examples\/:" monads/scripts/checkExample || die
}

src_install() {
	dodir /opt/${PN}

	mv monads/scripts ${D}/opt/${PN} || die
	mv monads/test ${D}/opt/${PN} || die
	mv monads/examples ${D}/opt/${PN} || die

	dosym /opt/${PN}/scripts/checkExample /usr/bin/aam-checkExample
	dosym /opt/${PN}/examples /usr/share/doc/${PF}/html/monads/examples 

	dohtml -r monads
	
	# examples dir needs to be writeable by the users group
	# for the aam-checkExample script
	fperms 775 /opt/${PN}/examples || die
	fowners root:users /opt/${PN}/examples || die
}