# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rebar3

DESCRIPTION="Port compiler Rebar3 plugin for native code"
HOMEPAGE="https://github.com/blt/port_compiler"
#SRC_URI="https://repo.hex.pm/tarballs/${P}.tar"
SRC_URI="
	https://github.com/blt/port_compiler/archive/refs/tags/v1.15.0.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/port_compiler-${PV}"

# src_unpack() {
# 	mkdir "${S}" || die
# 	tar -O -xf "${DISTDIR}"/${P}.tar contents.tar.gz |
# 		tar -xzf - -C "${S}"
# 	assert
# }
