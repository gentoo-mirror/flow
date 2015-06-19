# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

DESCRIPTION="On the computer you wish to control."
HOMEPAGE="http://www.gmote.org"
SRC_URI="http://sites.google.com/site/marcsto/GmoteServerLinux${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/jre
		media-video/vlc"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

src_prepare() {
	rm "GmoteServerLinux${PV}/GmoteServer.sh~"
}

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r GmoteServerLinux${PV}/* || die "failed to install ${PN}"

	dodir /usr/bin
	exeinto /usr/bin
	echo -e '#!/bin/sh \n cd /opt/gmote-server \n sh GmoteServer.sh "$@"'>> ${PN}
	doexe ${PN}

	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/${PN}.png || die

	make_desktop_entry ${PN} "Gmote Server" ${PN} "Network"
}
