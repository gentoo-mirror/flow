# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gnome Herbstluftwm session"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	gnome-base/gnome-session
	x11-wm/herbstluftwm
"

S="${WORKDIR}"

src_install() {
	# https://wiki.archlinux.org/title/GNOME/Tips_and_tricks#Custom_GNOME_sessions
	insinto /usr/share/gnome-session/sessions
	newins - gnome-herbstluftwm.session <<-EOF
	[GNOME Session]
	Name=GNOME Herbstluftwm
	RequiredComponents=herbstluftwm;gnome-settings-daemon;
EOF

	insinto /usr/share/xsessions
	newins - gnome-herbstluftwm.desktop <<-EOF
	[Desktop Entry]
	Name=GNOME Herbstluftwm
	Exec=gnome-session --session=gnome-herbstluftwm
EOF
}
