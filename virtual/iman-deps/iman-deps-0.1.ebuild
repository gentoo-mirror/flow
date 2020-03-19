# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Virtual for the dependencies required by the InvasIC Manager (iman)"
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="
	>=dev-python/yapf-0.29.0
	dev-python/libtmux
	dev-python/pexpect
	dev-python/pytest
	dev-python/pyxdg
"
