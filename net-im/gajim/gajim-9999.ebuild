# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.14.1-r2.ebuild,v 1.8 2011/03/29 12:43:44 jer Exp $

EAPI="3"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite xml"

inherit eutils python versionator mercurial

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
EHG_REPO_URI="http://hg.gajim.org/gajim"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="avahi crypt dbus gmail gnome idle jingle libnotify networkmanager nls spell srv X xhtml"

COMMON_DEPEND="
	x11-libs/gtk+:2
	dev-python/pygtk:2"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/gettext-0.17-r1
	>=dev-util/intltool-0.40.1
	dev-util/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	dev-python/python-nbxmpp
	dev-python/pygoocanvas
	dev-python/pyopenssl
	dev-python/gnome-keyring-python
	crypt? (
		app-crypt/gnupg
		dev-python/pycrypto
		net-im/python-otr
		)
	dbus? (
		dev-python/dbus-python
		dev-libs/dbus-glib
		libnotify? ( dev-python/notify-python )
		avahi? ( net-dns/avahi[dbus,gtk,python] )
		)
	gmail? ( net-dns/bind-tools )
	gnome? (
		dev-python/libgnome-python
		dev-python/gnome-keyring-python
		dev-python/egg-python
		)
	idle? ( x11-libs/libXScrnSaver )
	jingle? ( net-libs/farstream[python] )
	networkmanager? (
			dev-python/dbus-python
			net-misc/networkmanager
		)
	srv? (
		|| (
			dev-python/libasyncns-python
			net-dns/bind-tools )
		)
	spell? ( app-text/gtkspell )
	xhtml? ( dev-python/docutils )"

pkg_setup() {
	if ! use dbus; then
		if use libnotify; then
			eerror "The dbus USE flag is required for libnotify support"
			die "USE=\"dbus\" needed for libnotify support"
		fi
		if use avahi; then
			eerror "The dbus USE flag is required for avahi support"
			die "USE=\"dbus\" needed for avahi support"
		fi
	fi
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	./autogen.sh
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with X x) \
		--docdir="/usr/share/doc/${PF}" \
		--libdir="$(python_get_sitedir)" \
# Enable site packages installs the shiped plugins into the wrong directory
#		--enable-site-packages
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dohtml README.html || die
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
