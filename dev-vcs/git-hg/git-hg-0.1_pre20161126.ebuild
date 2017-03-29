# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="A git utility for checking out and tracking a mercurial repo."
HOMEPAGE="https://github.com/cosmin/git-hg"
SRC_URI=""
EGIT_REPO_URI="https://github.com/vapier/git-hg.git"
EGIT_COMMIT="3abc14509807912ad8f7a15b08c6c95942b63004"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"
