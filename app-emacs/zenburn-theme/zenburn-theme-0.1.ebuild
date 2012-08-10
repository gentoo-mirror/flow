# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit elisp

DESCRIPTION="Zenburn color theme for Emacs 24 (or higher)"
HOMEPAGE="https://github.com/Flowdalic/zenburn-emacs"
SRC_URI="mirror://github/Flowdalic/zenburn-emacs/zenburn-emacs-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	>=virtual/emacs-24"

SITEFILE="50${PN}-gentoo-${PV}.el"

S="${WORKDIR}"

