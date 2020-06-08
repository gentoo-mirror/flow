# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"

inherit git-r3 pam cmake

EGIT_REPO_URI="https://github.com/neithernut/pam_e4crypt.git"
EGIT_COMMIT_ID="0828bc97330669164e13a1cf1c53be43d9c76656"
KEYWORDS="~amd64 ~x86"

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

	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/$(get_libdir)"
	)
	cmake_src_configure
}
