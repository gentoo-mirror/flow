# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PV="${PV/_/-}"

DESCRIPTION="XMPP gateway to IRC"
HOMEPAGE="https://biboumi.louiz.org/"
SRC_URI="https://git.louiz.org/biboumi/snapshot/biboumi-${MY_PV}.tar.xz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+idn logrotate postgres +sqlite +ssl systemd udns"

DEPEND="
	dev-libs/expat
	virtual/libiconv
	sys-apps/util-linux
	sqlite? ( dev-db/sqlite:3 )
	postgres? ( dev-db/postgresql:* )
	idn? ( net-dns/libidn:= )
	udns? ( net-libs/udns )
	ssl? ( dev-libs/botan:2= )
	!ssl? ( dev-libs/libgcrypt )
	systemd? ( sys-apps/systemd:= )
"
BDEPEND="dev-python/sphinx"
RDEPEND="
	${DEPEND}
	acct-user/biboumi
"

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS=( README.rst CHANGELOG.rst doc/user.rst )

src_configure() {
	local mycmakeargs=(
		-DSERVICE_USER="${PN}"
		-DSERVICE_GROUP="${PN}"

		-DWITH_BOTAN="$(usex ssl)"
		-DWITH_LIBIDN="$(usex idn)"
		-DWITH_SYSTEMD="$(usex systemd)"
		-DWITH_UDNS="$(usex udns)"
		-DWITH_SQLITE3="$(usex sqlite)"
		-DWITH_POSTGRESQL="$(usex postgres)"

		# The WITHOUT_* is really needed.
		# TODO: Check if this is still the case on version bumps.
		-DWITHOUT_SYSTEMD="$(usex systemd no yes)"
		-DWITHOUT_POSTGRESQL="$(usex postgres no yes)"
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	cmake_build man
}

src_install() {
	cmake_src_install

	if ! use systemd; then
		newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/${PN}.logrotate.systemd" "${PN}"
		newins "${FILESDIR}/${PN}.logrotate.openrc" "${PN}"
	fi

	diropts --owner=biboumi --group=biboumi --mode=750
	if use sqlite; then
		keepdir /var/lib/biboumi
	fi
	keepdir /var/log/biboumi

	insinto /etc/biboumi
	insopts --group=biboumi --mode=640
	newins conf/biboumi.cfg biboumi.cfg.example
}
