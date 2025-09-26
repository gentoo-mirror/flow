# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Test ebuild for new EAPI features"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

src_install() {
	local destdir=/var/lib/${PN}

	insinto ${destdir}
	newins - symlink-target <<-EOF
	This is the symlink target
EOF
	dosym ${destdir}/symlink-target ${destdir}/symlink-test
}
