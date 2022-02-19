# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

GITHUB_COORDINATES="compudj/librseq"

EGIT_REPO_URI="https://github.com/${GITHUB_COORDINATES}.git"
EGIT_COMMIT="170f840b498e1aff068b90188727a656111bfc2f"

KEYWORDS="~amd64 ~x86"

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
