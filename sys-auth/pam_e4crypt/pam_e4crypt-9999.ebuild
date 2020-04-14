# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"

inherit pam cmake

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/neithernut/pam_e4crypt.git"
else
	SRC_URI="https://github.com/neithernut/pam_e4crypt/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="PAM module for unlocking transparently encrypted ext4 directories"
HOMEPAGE="https://github.com/neithernut/pam_e4crypt"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	sys-libs/pam
	sys-apps/util-linux
	sys-apps/keyutils
"
RDEPEND="${DEPEND}"

DOCS="README.md"

src_configure() {
	pammod_hide_symbols

	cmake_src_configure
}
