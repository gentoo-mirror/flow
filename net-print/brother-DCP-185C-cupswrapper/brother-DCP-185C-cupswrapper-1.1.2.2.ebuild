# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DESCRIPTION="Brother DCP-185C CUPS wrapper"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/dcp185ccupswrapper-1.1.2-2.i386.rpm"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=net-print/brother-DCP-185C-lpr-1.1.2.2"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/adjust-services-links.patch"
)

# src_prepare() {
# 	eapply "${FILESDIR}/adjust-services-links.patch"
# }

src_install(){
	cp * -vr ${D}
}

pkg_postinst() {
	elog "Now run the wrapper located in:"
	elog "/usr/local/Brother/Printer/dcp185c/cupswrapper/cupswrapperdcp185c"
}
