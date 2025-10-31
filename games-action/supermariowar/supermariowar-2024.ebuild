# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="smw"
MY_DATA_COMMIT_ID="1139d89ef7e38368536317afd7db54cea2488d5b"

DESCRIPTION="Fan-made multiplayer Super Mario Bros. style deathmatch game"
HOMEPAGE="https://github.com/mmatyas/supermariowar"
SRC_URI="
	https://github.com/mmatyas/${PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/mmatyas/${PN}-data/archive/${MY_DATA_COMMIT_ID}.tar.gz
		-> ${PN}-data-2024-10-04.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-cpp/yaml-cpp:=
	media-libs/libsdl2[joystick]
	media-libs/sdl2-mixer[vorbis]
	media-libs/sdl2-image[png,jpeg]
	net-libs/enet:1.3=
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC_LIBS=OFF
		-DSMW_BINDIR="${EPREFIX}"/usr/bin
		-DSMW_DATADIR="${EPREFIX}"/usr/share/${PF}
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	local smw_datadir="usr/share/${PF}"
	local smw_bindir="${smw_datadir}/bin"
	mkdir -p "${ED}/${smw_bindir}" || die

	ebegin "Moving ${PN} binary files to /${smw_bindir}"
	mv "${ED}"/usr/bin/* "${ED}/${smw_bindir}"
	eend $? || die

	insinto "${smw_bindir}/data"
	doins -r "${WORKDIR}/${PN}-data-${MY_DATA_COMMIT_ID}"/*

	local bin base_bin
	for bin in "${ED}/${smw_bindir}/"*; do
		base_bin="${bin##*/}"
		newbin - ${base_bin} <<-EOF
		#!/usr/bin/env bash
		# Copyright 1999-2025 Gentoo Authors
		# Distributed under the terms of the GNU General Public License v2
		# ${PF} launcher: ${base_bin}
		exec "/${EPREFIX}/${smw_bindir}/${base_bin}" "$@"
		EOF
	done

	ebegin "Installing ${MY_PN}-server files"
	local smw_serverdir="/${smw_datadir}/server"
	insinto "${smw_serverdir}"
	doins "${S}"/src/server/serverconfig
	dosym "${smw_serverdir}"/serverconfig /etc/${MY_PN}d.conf
	newinitd "${FILESDIR}"/smwd.initd ${MY_PN}d
	sed -e "s#@SMW_SERVERDIR@#${smw_serverdir}#g;" \
		-i "${ED}"/etc/init.d/${MY_PN}d
	eend $? || die
}
