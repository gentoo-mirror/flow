# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gnome Herbstluftwm session"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-wm/herbstluftwm"
RDEPEND="
	gnome-base/gnome-flashback
	x11-wm/herbstluftwm
"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/applications
	doins "${EROOT}/usr/share/xsessions/herbstluftwm.desktop"

	# https://wiki.archlinux.org/title/GNOME/Tips_and_tricks#Custom_GNOME_sessiosn
	insinto /usr/share/gnome-session/sessions
	newins - gnome-flashback-herbstluftwm.session <<-EOF
	[GNOME Session]
	Name=GNOME Flashback (Herbstluftwm)
	RequiredComponents=herbstluftwm;gnome-flashback;gnome-panel;org.gnome.SettingsDaemon.A11ySettings;org.gnome.SettingsDaemon.Color;org.gnome.SettingsDaemon.Datetime;org.gnome.SettingsDaemon.Housekeeping;org.gnome.SettingsDaemon.Keyboard;org.gnome.SettingsDaemon.MediaKeys;org.gnome.SettingsDaemon.Power;org.gnome.SettingsDaemon.PrintNotifications;org.gnome.SettingsDaemon.Rfkill;org.gnome.SettingsDaemon.ScreensaverProxy;org.gnome.SettingsDaemon.Sharing;org.gnome.SettingsDaemon.Smartcard;org.gnome.SettingsDaemon.Sound;org.gnome.SettingsDaemon.UsbProtection;org.gnome.SettingsDaemon.Wacom;org.gnome.SettingsDaemon.XSettings;
EOF

	insinto /usr/share/xsessions
	newins - gnome-flashback-herbstluftwm.desktop <<-EOF
	[Desktop Entry]
	Name=GNOME Flashback (Herbstluftwm)
	Exec=gnome-session --session=gnome-flashback-herbstluftwm
EOF
}
