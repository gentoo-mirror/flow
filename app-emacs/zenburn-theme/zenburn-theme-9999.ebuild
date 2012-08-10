# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit elisp git-2

#MY_P
DESCRIPTION="Zenburn color theme for Emacs 24 (or higher)"
HOMEPAGE="https://github.com/Flowdalic/zenburn-emacs"
SRC_URI=""
EGIT_REPO_URI="git://github.com/Flowdalic/zenburn-emacs.git
	https://github.com/Flowdalic/zenburn-emacs.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
# Add strip here if it's an binary ebuild
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	>=virtual/emacs-24"
