# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit elisp git-2

DESCRIPTION="Zenburn color theme for Emacs 24 (or higher)"
HOMEPAGE="https://github.com/bbatsov/zenburn-emacs"
SRC_URI=""
EGIT_REPO_URI="git://github.com/bbatsov/zenburn-emacs.git
	https://github.com/bbatsov/zenburn-emacs.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=virtual/emacs-24"

SITEFILE="50${PN}-gentoo-${PV}.el"

DOCS="README.md"

src_prepare() {
	cp ${FILESDIR}/${SITEFILE} .
	local zb_sha256sum
	sb_sha256sum=$(sha256sum zenburn-theme.el | cut -f1 -d " ")
	echo "(add-to-list 'custom-safe-themes \"${sb_sha256sum}\")" >> ${SITEFILE}
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install ${SITEFILE} || die
	dodoc ${DOCS} || die
}

