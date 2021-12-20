# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Java library/compiler for the Cap'n Proto serialization/RPC protocol"
HOMEPAGE="https://github.com/capnproto/java-capnproto"
SRC_URI="https://github.com/capnproto/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

DEPEND="dev-libs/capnproto"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/0001-Makefile-respect-CFLAGS-and-LDFLAGS.patch
	"${FILESDIR}"/0002-Makefile-Use-install-to-install-and-respect-DESTDIR.patch
	"${FILESDIR}"/0003-Makefile-Use-non-local-prefix-per-default.patch
)
