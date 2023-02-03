# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gnome Herbstluftwm session (via Gnome Flashback)"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="gnome-base/gnome-flashback"
RDEPEND="
	${DEPEND}
	>=x11-wm/herbstluftwm-0.9.5-r1
"

S="${WORKDIR}"

src_install() {
	# https://wiki.archlinux.org/title/GNOME/Tips_and_tricks#Custom_GNOME_sessions

	# Create the gnome-flashback-herbstluftwm session configuration by
	# simply replacing Metacity with Herbstluftwm from
	# gnome-flashback-metacity.session. Note that one should not do
	# something like that in an offical package.
	insinto /usr/share/gnome-session/sessions
	sed \
		-e 's/Metacity/Herbstluftwm/' \
		-e 's/metacity/herbstluftwm/' \
		"${EROOT}"/usr/share/gnome-session/sessions/gnome-flashback-metacity.session |\
		newins - gnome-flashback-herbstluftwm.session
	assert

	insinto /usr/share/xsessions
	newins - gnome-flashback-herbstluftwm.desktop <<-EOF
	[Desktop Entry]
	Name=GNOME Flashback (Herbstluftwm)
	Exec=gnome-session --session=gnome-flashback-herbstluftwm
EOF
}
