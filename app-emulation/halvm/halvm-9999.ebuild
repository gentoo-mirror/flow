# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils git-r3 multilib

DESCRIPTION="The Haskell Lightweight Virtual Machine (HaLVM)"
HOMEPAGE="https://galois.com/project/halvm/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/GaloisInc/HaLVM.git
	https://github.com/GaloisInc/HaLVM.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
# Add strip here if it's an binary ebuild
RESTRICT="mirror"

DEPEND=""
RDEPEND="app-emulation/xen
	app-emulation/qemu
	${DEPEND}"

src_prepare() {
	eautoreconf
	epatch "${FILESDIR}/${PN}-config-libdir.patch"
}

src_configure() {
	econf \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--prefix="${EPREFIX}/usr/"
}

src_compile() {
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install
}
