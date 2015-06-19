# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils versionator

MY_PN=${PN%%-bin}
MY_PN_SHORT=${MY_PN%%-community}
MY_PV="$(get_version_component_range 4-5)"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE (Community Edition)"
HOMEPAGE="http://jetbrains.com/idea/"
SRC_URI="http://download.jetbrains.com/${MY_PN_SHORT}/${MY_PN_SHORT}IC-$(get_version_component_range 1-3).tar.gz"

LICENSE="Apache-2.0"
SLOT="$(get_major_version)"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/${MY_PN_SHORT}-IC-${MY_PV}"

src_install() {
	local dir="/opt/${P}"
	local bin="${PN}-${SLOT}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${MY_PN_SHORT}.sh" "${dir}/bin/fsnotifier" "${dir}/bin/fsnotifier64"

	newicon "bin/${MY_PN_SHORT}.png" "${bin}.png"
	make_wrapper "${bin}" "/opt/${P}/bin/${MY_PN}.sh"
	make_desktop_entry ${bin} "IntelliJ IDEA $(get_version_component_range 1-3)	(Community Edition)" "${bin}" "Development;IDE"
}
