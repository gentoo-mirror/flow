# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Virtual for all the essential GUI packages"
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="amd64"

IUSE=""
RDEPEND="
	app-text/pdfgrep
	media-sound/pavucontrol
	www-client/firefox
	x11-apps/xsetroot
	x11-apps/xinput
	x11-apps/xkbprint
	x11-apps/setxkbmap
	x11-misc/nitrogen
	x11-wm/herbstluftwm
	virtual/flows-font-selection
"
