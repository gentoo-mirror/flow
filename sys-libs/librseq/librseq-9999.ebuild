# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

GITHUB_COORDINATES="compudj/librseq"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${GITHUB_COORDINATES}.git"
else
	SRC_URI="https://github.com/${GITHUB_COORDINATES}/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Library for Restartable Sequences"
HOMEPAGE="https://github.com/${GITHUB_COORDINATES}"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="
	>=sys-kernel/linux-headers-4.18
"
RDEPEND="${DEPEND}"

if [[ -n "${EGIT_REPO_URI}" ]]; then
	src_prepare() {
		default
		eautoreconf
	}
fi
