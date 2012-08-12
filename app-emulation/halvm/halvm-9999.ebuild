# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils git-2

#MY_P
DESCRIPTION="The Haskell Lightweight Virtual Machine (HaLVM)"
HOMEPAGE="http://halvm.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/GaloisInc/HaLVM.git
	https://github.com/GaloisInc/HaLVM.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
# Add strip here if it's an binary ebuild
RESTRICT="mirror"

DEPEND=""
RDEPEND="app-emulation/xen
	app-emulation/qemu
	${DEPEND}"

#S="${WORKDIR}/${P}"

src_prepare() {
	eautoreconf
}

src_compile() {
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install
}
