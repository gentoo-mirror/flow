# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EHG_REPO_URI="https://go.googlecode.com/hg"
[[ ${PV} == "9999" ]] && vcs_eclass="mercurial"
inherit ${vcs_eclass} bash-completion elisp-common pax-utils
unset vcs_eclass

if [[ ${PV} != "9999" ]]; then
	KEYWORDS="~x86"
	SRC_URI="mirror://gentoo/${TARBALL}"
fi

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="http://www.golang.org"

LICENSE="BSD-2"
SLOT="0"
IUSE="emacs hardened kate vim-syntax zsh-completion"

DEPEND="sys-apps/ed"
RDEPEND="emacs? ( virtual/emacs )
	vim-syntax? ( app-editors/vim )
	zsh-completion? ( app-shells/zsh-completion )"

src_compile()
{
	export HOST_EXTRA_CFLAGS="${CFLAGS}"
	export HOST_EXTRA_LDFLAGS="${LDFLAGS}"
	export GOROOT_FINAL=/usr/lib/go
	export GOROOT="$(pwd)"
	export GOBIN="$GOROOT/bin"

	cd src
	./all.bash
	cd ..
	if use emacs; then
		elisp-compile misc/emacs/*.el
	fi
}

src_install()
{
	dobin bin/*
	dodoc AUTHORS CONTRIBUTORS LICENSE PATENTS README
	newenvd "${FILESDIR}/go.envd"  90go
	dobashcompletion "misc/bash/go"

	dodir /usr/lib/go
	insinto /usr/lib/go
	doins -r pkg
	dodir /usr/lib/go/src
	insinto /usr/lib/go/src
	doins src/Make*

	if use emacs; then
		elisp-install ${PN} misc/emacs/*.el misc/emacs/*.elc
	fi

	if use kate; then
		dodir /usr/share/apps/katepart/syntax
		insinto /usr/share/apps/katepart/syntax
		doins misc/kate/go.xml
	fi

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins misc/vim/syntax/*
		insinto /usr/share/vim/vimfiles/ftdetect
		doins misc/vim/ftdetect/*
	fi

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		doins "misc/zsh/go"
	fi
}

pkg_postinst()
{
	if use emacs; then
		elisp-site-regen
	fi
	bash-completion_pkg_postinst
}

pkg_postrm()
{
	if use emacs; then
		elisp-site-regen
	fi
}