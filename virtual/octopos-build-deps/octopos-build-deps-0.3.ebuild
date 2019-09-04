# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Virtual for the dependencies required by OctoPOS"
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="app-doc/doxygen
	cross-sparc-unknown-elf/gcc[cxx]
	dev-perl/Tie-IxHash
	dev-lang/nasm
	sys-devel/crossdev
	>=sys-devel/aspectc++-bin-2.1"
