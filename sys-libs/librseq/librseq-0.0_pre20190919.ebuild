# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

GITHUB_COORDINATES="compudj/librseq"

EGIT_REPO_URI="https://github.com/${GITHUB_COORDINATES}.git"
EGIT_COMMIT="152600188dd214a0b2c6a8c66380e50c6ad27154"

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
