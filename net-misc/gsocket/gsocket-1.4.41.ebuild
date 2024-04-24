# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Connect like there is no firewall. Securely."
HOMEPAGE="https://www.gsocket.io/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hackerschoice/gsocket.git"
else
	SRC_URI="https://github.com/hackerschoice/gsocket/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2"
SLOT="0"

DEPEND="dev-libs/openssl:="
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
