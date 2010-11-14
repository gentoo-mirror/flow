# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Displays PDF presentation slides with style."

MY_P="Impressive-${PV}"

HOMEPAGE="http://impressive.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="gs mplayer"

S="${WORKDIR}/${MY_P}"

RDEPEND="dev-lang/python
	dev-python/pyopengl
	dev-python/pygame
	dev-python/imaging
	!gs? ( app-text/xpdf )
	gs? ( virtual/ghostscript )
	x11-misc/xdg-utils
	mplayer? ( media-video/mplayer )"
DEPEND=""

src_install() {
	mv changelog.txt ChangeLog
	dodoc ChangeLog || die "dodoc failed"
	doman impressive.1 || die "doman failed"
	dohtml impressive.html || die "dohtml failed"

	mv impressive{.py,}
	dobin impressive || die "dobin failed"
}
