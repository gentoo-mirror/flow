# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A virtual package for selected fonts (by flow)"
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="amd64"

IUSE=""

# dejavu: nice font
# quivira: for all glyphs
# note-emoji: for emojis
RDEPEND="
	media-fonts/dejavu
	media-fonts/quivira
	media-fonts/noto-emoji
"
