# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EHG_REPO_URI="https://go.googlecode.com/hg"
[[ ${PV} == "9999" ]] && vcs_eclass="mercurial"
inherit ${vcs_eclass} 
unset vcs_eclass

# if [[ ${PV} != "9999" ]]; then
# 	KEYWORDS="~x86"
# 	SRC_URI="mirror://gentoo/${TARBALL}"
# fi

DESCRIPTION="The official Go documentation bundle"
HOMEPAGE="http://www.golang.org"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dohtml -A pdf -r doc/*
}