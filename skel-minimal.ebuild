# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://foo.example.org/"
SRC_URI="ftp://foo.example.org/${P}.tar.gz"

S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"

KEYWORDS="~amd64"

IUSE="gnome X"

RESTRICT="strip"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
