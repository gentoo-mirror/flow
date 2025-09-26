# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit greadme

DESCRIPTION="Test ebuild for the greadme.eclass"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"

RESTRICT="binpkg unknown"

S="${WORKDIR}"

src_install() {
	greadme_stdin <<-EOF
		This is an example content of the readme file.
	EOF
}
