# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A high performance C++ OpenPGP library"
HOMEPAGE="https://github.com/rnpgp/rnp"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rnpgp/${PN}.git"
else
	SRC_URI="https://github.com/rnpgp/${PN}/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0 BSD-2"
SLOT="0"
IUSE=""

BDEPEND=">=dev-util/cmake-3.14"

DEPEND="
	dev-libs/botan
"
RDEPEND="${DEPEND}"

src_prepare() {
	# TODO: Replace this with a gentoo specific version.cmake, which
	# emits the right version.
	cp "${FILESDIR}/c78a0be-version.cmake" "${S}/cmake/version.cmake" || die

	cmake_src_prepare

	# TODO: Enable FEATURE="test".
	cmake_comment_add_subdirectory src/tests
}
