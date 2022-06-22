# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="The OpenCilk concurrency platform for parallel programming"
HOMEPAGE="https://opencilk.org/"

SRC_URI="
	https://github.com/OpenCilk/opencilk-project/archive/refs/tags/opencilk/v${PV}.tar.gz -> ${PN}-project-${PV}.tar.gz
	https://github.com/OpenCilk/cheetah/archive/refs/tags/opencilk/v${PV}.tar.gz -> ${PN}-cheetah-${PV}.tar.gz
	https://github.com/OpenCilk/productivity-tools/archive/refs/tags/opencilk/v${PV}.tar.gz -> ${PN}-productivity-tools-${PV}.tar.gz
"

# TODO: Since opencilk-project is a fork of LLVM, there probably should
# be a bunch more licenses here, namely the LLVM ones. OpenCilk only
# states MIT license. Thiys needs more investigation.
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

MY_POSTFIX="${PN}-v${PV}"
S="${WORKDIR}/${PN}-project-${MY_POSTFIX}"
CMAKE_USE_DIR="${S}/llvm"

PATCHES=(
	"${FILESDIR}"/llvm-libsanitizer-Remove-cyclades-inclusion-in-sanitizer.patch
)

src_prepare() {
	local -A symlinks
	symlinks["${S}/cheetah"]="${WORKDIR}/cheetah-${MY_POSTFIX}"
	symlinks["${S}/cilktools"]="${WORKDIR}/productivity-tools-${MY_POSTFIX}"

	local link target
	for link in "${!symlinks[@]}"; do
		target="${symlinks[${link}]}"
		ln -rs "${target}" "${link}" || die
	done

	cmake_src_prepare
}

src_configure() {
	append-ldflags $(no-as-needed)
	local mycmakeargs=(
		"-DLLVM_ENABLE_PROJECTS=clang;compiler-rt"
		"-DLLVM_ENABLE_RUNTIMES=cheetah;cilktools"
		-DLLVM_TARGETS_TO_BUILD=host
		-DLLVM_ENABLE_ASSERTIONS=ON
	)
	cmake_src_configure
}
