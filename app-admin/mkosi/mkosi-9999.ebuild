# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="A tool for generating OS images"
HOMEPAGE="https://github.com/systemd/${PN}"

if [[ "${PV}" == "9999" ]] || [[ -n "${EGIT_COMMIT_ID}" ]]; then
	EGIT_REPO_URI="https://github.com/systemd/mkosi.git"
	inherit git-r3
	if [[ "${PV}" == "9999" ]]; then
		MY_KEYWORDS=""
	fi
else
	SRC_URI="https://github.com/systemd/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+debian"

# Even tough mkosi requires systemd, but systemd is not available in
# all gentoo profiles.
RDEPEND="
	debian? ( dev-util/debootstrap )
"

# Disabled as mkosi does not (yet) detect Gentoo as host distribution.
# distutils_enable_tests pytest
