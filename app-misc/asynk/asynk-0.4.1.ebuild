# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 python-utils-r1

#MY_P
DESCRIPTION="A flexible Contacts synchronization program that works with a variety of contacts software"
HOMEPAGE="http://karra-asynk.appspot.com/"
SRC_URI="http://karra-asynk.appspot.com/downloads/${PN}-v${PV}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
# Add strip here if it's an binary ebuild
RESTRICT="mirror"

DEPEND=""
# TODO argparse python??
RDEPEND="${DEPEND}
	dev-python/iso8601
	dev-python/demjson"

S="${WORKDIR}/${PN}-v${PV}"


#src_configure() {
#}

#src_compile() {
	#emake || die
#}

src_install() {
	dodoc README.org
	dobin state.init.json config.json
	python_foreach_impl python_domodule ${PN}/*
	python_foreach_impl python_newscript asynk.py ${PN}

}
