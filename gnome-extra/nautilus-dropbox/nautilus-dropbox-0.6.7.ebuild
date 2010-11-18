# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnome2 eutils linux-info

DESCRIPTION="Store, Sync and Share Files Online"
HOMEPAGE="http://www.getdropbox.com/"
SRC_URI="http://www.dropbox.com/download?dl=packages/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-libs/glib:2
	dev-python/pygtk
	gnome-base/nautilus
	net-misc/wget
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXinerama"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-python/docutils"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} $(use_enable debug)"

CONFIG_CHECK="INOTIFY_USER"

pkg_setup () {
        linux-info_pkg_setup
	enewgroup dropbox
}

src_install () {
	gnome2_src_install

	local extensiondir="$(pkg-config --variable=extensiondir libnautilus-extension)"
        [ -z ${extensiondir} ] && die "pkg-config was unable to get nautilus extensions dir"

	find "${D}" -name '*.la' -exec rm -f {} + || die

	fowners root:dropbox "${extensiondir}"/libnautilus-dropbox.{a,so} || die
	fperms o-rwx "${extensiondir}"/libnautilus-dropbox.{a,so} || die
}

pkg_postinst () {
	gnome2_pkg_postinst

	elog "Add any users who wish to have access to the dropbox nautilus"
	elog "plugin to the group 'dropbox'."
	elog
	elog "If you've installed old version, maybe you need too"
	elog "remove \${HOME}/.dropbox-dist first."
	elog
	elog " $ rm -rf \${HOME}/.dropbox-dist"
	elog " $ dropbox start -i"
}
