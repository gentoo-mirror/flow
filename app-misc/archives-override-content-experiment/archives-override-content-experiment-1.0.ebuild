# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An experiment about archives being able to override files"
HOMEPAGE="https://github.com/Flowdalic/"

SRC_URI="
	https://dev.gentoo.org/~flow/${PN}/${PN}-benign-1.0.tar
	https://dev.gentoo.org/~flow/${PN}/${PN}-malicious-1.0.tar
"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
