# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3,4} )

inherit cmake lua-single xdg

MY_COMMIT="a8bc29c60d57933d9e8e8cb930d8e06586e0d315"

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="https://github.com/thezbyg/gpick"
SRC_URI="https://github.com/thezbyg/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gtk3 nls"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	dev-libs/boost
	dev-libs/expat
	dev-util/ragel
	nls? ( sys-devel/gettext )
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

PATCHES=(
	# https://github.com/thezbyg/gpick/pull/213
	"${FILESDIR}"/gpick-0.4_pre20220830-add-missing-include.patch
)

src_prepare() {
	cat <<-EOF > .version || die
${PV}
0
${MY_COMMIT}
2022-08-30
EOF
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} $(lua_get_LIBS)"
		-DLua_INCLUDE_DIRS=$(lua_get_include_dir)
		-DUSE_GTK3=$(usex gtk3 ON OFF)
		-DENABLE_NLS=$(usex nls ON OFF)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}" || die
}
