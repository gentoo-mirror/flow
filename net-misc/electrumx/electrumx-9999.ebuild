# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit eutils distutils-r1 systemd user

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/kyuupichan/electrumx.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/kyuupichan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A server for the Electrum wallet"
HOMEPAGE="https://github.com/kyuupichan/electrumx"

LICENSE="MIT"

SLOT="0"

IUSE=""

RDEPEND="dev-python/plyvel
	>=dev-python/aiohttp-1.0
	>=dev-python/pylru-1.0
	${DEPEND}"

pkg_setup() {
	enewuser "${PN}" -1 -1 "/var/lib/${PN}"
}

MY_SYSTEMD_SERVICE_FILE="contrib/systemd/${PN}.service"

src_prepare() {
	default

	if [[ -n $EGIT_REPO_URI ]]; then
		sed -i "s/find_packages()/find_packages(exclude=('tests',))/" setup.py || die
	fi

	sed -i "s;/usr/local/bin;/usr/bin;" "${MY_SYSTEMD_SERVICE_FILE}" || die
	sed -i "s;/etc/${PN}.conf;/etc/${PN}/${PN}.conf;" "${MY_SYSTEMD_SERVICE_FILE}" || die
}

python_install_all() {
	distutils-r1_python_install_all

	local electrumx_home="/var/lib/${PN}"
	dodir "${electrumx_home}"
	fperms 700 "${electrumx_home}"

	systemd_dounit "${MY_SYSTEMD_SERVICE_FILE}"
}
