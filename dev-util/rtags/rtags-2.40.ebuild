# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake systemd

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Andersbakken/rtags.git"
	SRC_URI=""
else
	RCT_COMMIT_ID="7067897ddc074480e0fce324f22a6f404ba8665b"
	RCT_TAR_GZ="rct-${RCT_COMMIT_ID}.tar.gz"
	SRC_URI="
	https://github.com/Andersbakken/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Andersbakken/rct/archive/${RCT_COMMIT_ID}.tar.gz -> ${RCT_TAR_GZ}
"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A client/server indexer for C/C++/ObjC[++] with integration for Emacs"
HOMEPAGE="http://www.rtags.net/"

# rtags is GPL-3 licensed, but the rct library (from the same author
# as rtags) is BSD-4 licensed.
LICENSE="GPL-3 BSD-4"
SLOT="0"
IUSE=""

# TODO:
# - dev-libs/openssl is an automagic dep of rct
# - sys-libs/zlib is an automagic dep of rct
# - is sys-libs/ncurses still required by rtags/rct?
DEPEND="
	sys-devel/clang:*
	sys-libs/ncurses:0
	sys-libs/zlib
	dev-libs/openssl:0=
"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	if [[ "${PV}" == "9999" ]]; then
		return
	fi

	rmdir "${S}/src/rct" || die
	ln -rs "${WORKDIR}"/rct-* "${S}/src/rct" || die
}

src_install() {
	cmake_src_install

	systemd_douserunit \
		"${FILESDIR}/rdm.socket" \
		"${FILESDIR}/rdm.service"
}
