# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Linux Test Project (LTP)"
HOMEPAGE="https://github.com/linux-test-project/ltp"
SRC_URI="https://github.com/linux-test-project/ltp/releases/download/${PV}/ltp-full-${PV}.tar.xz"

S="${WORKDIR}/${PN}-full-${PV}"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

# liburing?
COMMON_DEPEND="
	dev-libs/libaio
	dev-libs/openssl:=
	net-libs/libmnl:=
	net-libs/libtirpc:=
	sys-apps/acl
	sys-apps/keyutils:=
	sys-libs/libcap
	sys-process/numactl
"
RDEPEND="
	${COMMON_DEPEND}
	acct-user/nobody
	>=dev-lang/python-3
"
DEPEND="${COMMON_DEPEND}"
#BDEPEND="virtual/pkgconfig" XXX

QA_FLAGS_IGNORED=/opt/ltp/testcases/data/ldd01/

src_configure() {
	econf --prefix="${EPREFIX}"/opt/ltp
}
