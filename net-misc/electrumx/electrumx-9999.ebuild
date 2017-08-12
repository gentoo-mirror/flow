# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_5 )

inherit eutils distutils-r1 systemd user

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/kyuupichan/electrumx.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/kyuupichan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://github.com/kyuupichan/electrumx"

LICENSE="MIT"

SLOT="0"

IUSE=""

RDEPEND="dev-python/plyvel
	${DEPEND}"

pkg_setup() {
	enewuser "${PN}" -1 -1 "/var/lib/${PN}"
}

src_install() {
	default

	local electrumx_home="/var/lib/${PN}"
	dodir "${electrumx_home}"
	fperms 700 "${electrumx_home}"

	systemd_dounit "contrib/systemd/electrumx.service"
}
