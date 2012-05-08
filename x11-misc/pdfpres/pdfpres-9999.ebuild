# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
PYTHON_DEPEND="2"

inherit python git-2

MY_PN=pdfPres
DESCRIPTION="Dual head PDF presenter"
HOMEPAGE="http://www.uninformativ.de/projects/?q=pdfpres"
SRC_URI=""
EGIT_REPO_URI="git://github.com/vain/pdfPres.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#S=${WORKDIR}/vain-${MY_PN}-e01efb1

src_install() {
	dodoc README

	newbin legacy-notes-converter.py ${PN}-legacy-notes-converter
	python_convert_shebangs 2 "${D}"/usr/bin/${PN}-legacy-notes-converter

	dobin ${PN}
	doman man1/${PN}.1
}
