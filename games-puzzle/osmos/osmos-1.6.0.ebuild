# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="Simple, ambient, nice-looking growing game"
HOMEPAGE="http://www.hemispheregames.com/osmos/"
SRC_URI="Osmos_${PV}.tar.gz"

LICENSE="Osmos"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
IUSE=""
RESTRICT="fetch"

RDEPEND="media-libs/freetype
	media-libs/libvorbis
	media-libs/openal
	x11-libs/libX11
	virtual/opengl"

S=${WORKDIR}/${PN}
QA_PRESTRIPPED="/opt/Osmos/Osmos.bin32
	/opt/Osmos/Osmos.bin64"

src_prepare() {
	cd Osmos || die
	rm eula.txt Osmos || die
	mv * ..
	cd ..
	rm -r Osmos
	if use amd64 ; then
		MY_BIN=Osmos.bin64
		rm Osmos.bin32 || die
	fi
	if use x86 ; then
		MY_BIN=Osmos.bin32
		rm Osmos.bin64 || die
	fi
	rm Fonts/FortuneCity.ttf || die
	cp ${FILESDIR}/FortuneCity.ttf Fonts/ || die
}

src_install() {
	local my_dest=/opt/Osmos
	insinto "${my_dest}"
	doins -r . || die
	fperms ug+x "${my_dest}"/${MY_BIN} || die

	games_make_wrapper Osmos ./${MY_BIN} "${my_dest}"
	make_desktop_entry "${GAMES_BINDIR}"/Osmos Osmos "${my_dest}"/Icons/128x128.png Game
	prepgamesdirs "${my_dest}"
}
