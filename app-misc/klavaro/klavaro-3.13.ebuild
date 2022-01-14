# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools optfeature

DESCRIPTION="Another free touch typing tutor program"
HOMEPAGE="https://klavaro.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-util/intltool
	>=sys-devel/gettext-0.18.3
"
RDEPEND="
	dev-libs/glib:2
	net-misc/curl
	x11-libs/gtk+:3
	>=x11-libs/gtkdatabox-1.0.0
	x11-libs/pango
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-3.13-datadir.patch
	"${FILESDIR}"/${PN}-3.13-desktop-keywords.patch
)

src_prepare() {
	default

	eautoreconf
}

pkg_postinst() {
	optfeature "instructions via synthesized speech" app-accessibility/espeak
}
