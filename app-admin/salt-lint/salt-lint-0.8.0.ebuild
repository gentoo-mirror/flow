# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="CLI utiliy that checks for best practices in SaltStack"
HOMEPAGE="https://github.com/warpnet/salt-lint"
LICENSE="MIT"
SLOT="0"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/warpnet/salt-lint.git"
	inherit git-r3
else
	SRC_URI="https://github.com/warpnet/salt-lint/archive/refs/tags/v0.8.0.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RDEPEND="
	dev-python/pathspec
	dev-python/pyyaml
"

distutils_enable_tests pytest
