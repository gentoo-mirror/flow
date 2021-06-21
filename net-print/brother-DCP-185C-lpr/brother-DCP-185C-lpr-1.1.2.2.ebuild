# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DESCRIPTION="Brother DCP-185C LPR print drivers"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/dcp185clpr-1.1.2-2.i386.rpm"

LICENSE="Brother"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}
	app-text/a2ps"

S="${WORKDIR}"

QA_FLAGS_IGNORED="
	usr/bin/brprintconf_dcp185c
	usr/local/Brother/Printer/dcp185c/lpd/brdcp185cfilter
"

src_unpack () {
	   rpm_src_unpack ${A}
}

src_install(){
	cp * -vr "${ED}"
}
