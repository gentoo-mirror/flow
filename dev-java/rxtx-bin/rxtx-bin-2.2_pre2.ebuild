# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rxtx/rxtx-2.1.7.2-r3.ebuild,v 1.3 2010/07/07 14:40:33 phajdan.jr Exp $

EAPI=4

inherit java-pkg-2

DESCRIPTION="Native lib providing serial and parallel communication for Java"
HOMEPAGE="http://rxtx.qbang.org/wiki/index.php/Main_Page"
SRC_URI="http://rxtx.qbang.org/pub/rxtx/rxtx-2.2pre2-bins.zip"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="amd64 x86"

RDEPEND=">=virtual/jre-1.4"

DEPEND=">=virtual/jdk-1.4"

src_unpack() {
	default
	mv *${PN}* "${S}" || die
}

src_install() {
	java-pkg_dojar RXTXcomm.jar
	if use x86 ; then
		java-pkg_doso i686-pc-linux-gnu/*.so
	fi
	if use amd64 ; then
			java-pkg_doso x86_64-unknown-linux-gnu/*.so
	fi

	dodoc README
}