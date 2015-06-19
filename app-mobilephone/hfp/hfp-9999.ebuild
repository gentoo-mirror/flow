# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools flag-o-matic linux-info subversion

DESCRIPTION="A Bluetooth Hands-Free Profile server, which allows your Linux system to act as a speakerphone for your mobile phone."
HOMEPAGE="http://nohands.sourceforge.net"
SRC_URI=""
ESVN_REPO_URI="https://nohands.svn.sourceforge.net/svnroot/nohands/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa audiofile dbus qt"

DEPEND="media-libs/speex
	media-libs/alsa-lib
	dev-libs/dbus-glib"
RDEPEND="${DEPEND}
	net-wireless/bluez
	audiofile? ( media-libs/audiofile )"

CONFIG_CHECK="~CONFIG_BT ~CONFIG_BT_RFCOMM"

src_prepare() {
	eautoreconf
}

pkg_setup() {
	linux-info_pkg_setup
    append-ldflags $(no-as-needed)
}

src_configure() {
	econf \
		--disable-nghost \
		--disable-embedded \
		--disable-palmtop \
		$(use_enable alsa) \
		$(use_enable audiofile) \
		$(use_enable dbus) \
		$(use_enable oss)
}
