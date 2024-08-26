# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Reliable PostgreSQL Backup & Restore"
HOMEPAGE="https://pgbackrest.org https://github.com/pgbackrest/pgbackrest"
SRC_URI="https://github.com/${PN}/${PN}/archive/release/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-release-${PV}/src"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~arm64"

DEPEND="
	app-arch/bzip2
	app-arch/lz4:=
	app-arch/zstd:=
	>=dev-db/postgresql-10:=[icu,ssl]
	dev-lang/perl:0=
	dev-libs/libxml2:2
	dev-libs/openssl:0=
	net-libs/libssh2
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

# XXX: switch to meson-based build? make libssh2 and libzstd USE-flag controlled?

src_install() {
	default
	keepdir /var/log/pgbackrest/
}
