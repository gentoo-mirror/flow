# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Tools to aid administering Gentoo systems, like silent automatic updates"
HOMEPAGE="https://github.com/Flowdalic/gentools"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Flowdalic/gentools.git"
else
	SRC_URI="https://github.com/Flowdalic/gentools/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="${DEPEND}"

src_install() {
	dosbin update-system
}
