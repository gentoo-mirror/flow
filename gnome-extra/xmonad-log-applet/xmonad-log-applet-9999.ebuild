# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit gnome2 git flag-o-matic

DESCRIPTION="Gnome applet for displaying XMonad log"
HOMEPAGE="http://uhsure.com/xmonad-log-applet.html"
SRC_URI=""
EGIT_REPO_URI="http://git.uhsure.com/xmonad-log-applet.git"
EGIT_BOOTSTRAP="gnome2_src_prepare"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-apps/dbus-1.2
	>=dev-haskell/hdbus-0.4
	>=gnome-base/gnome-panel-2
	>=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.10"
DEPEND="${RDEPEND}"

pkg_setup() {
    append-ldflags $(no-as-needed)
}

src_install() {
	emake DESTDIR="${D}"  install || die "Install failed"
	dodoc "${FILESDIR}"/xmonad.hs || die
}

pkg_postinst() {
	       elog "Remember to update your xmonad.hs accordingly"
	       elog "a sample xmonad.hs is provided in the doc dir"
}
