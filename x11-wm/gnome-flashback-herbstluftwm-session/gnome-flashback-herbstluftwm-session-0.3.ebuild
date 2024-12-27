# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gnome Herbstluftwm session (via Gnome Flashback)"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"

DEPEND="gnome-base/gnome-flashback"
RDEPEND="
	${DEPEND}
	>=x11-wm/herbstluftwm-0.9.5-r1
"

# https://wiki.archlinux.org/title/GNOME/Tips_and_tricks#Custom_GNOME_sessions
# Create the gnome-flashback-herbstluftwm session configuration by
# simply replacing Metacity with Herbstluftwm from
# gnome-flashback-metacity.session. Note that one should not do
# something like that in an offical package.
src_compile() {
	sed \
		-e 's/Metacity/Herbstluftwm/' \
		-e 's/metacity/herbstluftwm/' \
		"${ESYSROOT}"/usr/share/gnome-session/sessions/gnome-flashback-metacity.session \
		> gnome-flashback-herbstluftwm.session || die
}

src_install() {
	insinto /usr/share/gnome-session/sessions
	doins gnome-flashback-herbstluftwm.session

	insinto /usr/share/xsessions
	newins - gnome-flashback-herbstluftwm.desktop <<-EOF
	[Desktop Entry]
	Name=GNOME Flashback (Herbstluftwm)
	Exec=gnome-session --session=gnome-flashback-herbstluftwm
EOF
}
