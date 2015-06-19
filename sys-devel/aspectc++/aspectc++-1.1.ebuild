# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A set of C++ language extensions to facilitate aspect-oriented programming with C/C++"
HOMEPAGE="http://www.aspectc.org"
SRC_URI="bootstrap-aspectc++? ( http://www.aspectc.org/fileadmin/downloads/ac/1.1/ac-1.1.tar.gz )
	bootstrap-aspectc++? ( http://www.aspectc.org/fileadmin/downloads/ac/1.1/ac-bin-linux-1.1.tar.gz )
	!bootstrap-aspectc++? ( http://www.aspectc.org/fileadmin/downloads/ac/1.1/ac-woven-1.1.tar.gz )"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+bootstrap-aspectc++"

RESTRICT="mirror"

DEPEND="sys-devel/gcc[cxx]
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

MY_AC="ac++"
MY_AG="ag++"

cmd_exists() {
	if command -v $1 &> /dev/null; then
		echo true
	else
		echo false
	fi
}

src_configure() {
	if use bootstrap-aspectc++ && ! command -v ac++ > /dev/null; then
		MY_AC="${S}/ac++"
		MY_AG="${S}/ag++"
	fi
}

src_compile() {
	local puma_extra

	if ! use bootstrap-aspectc++; then
		puma_extra=compile
	fi

	emake -C Puma $puma_extra ROOT="${S}/Puma" AC=$MY_AC AGXX=$MY_AG
	emake -C AspectC++ SHARED=1
	emake -C Ag++
}

src_install() {
	local release="AspectC++/bin/linux-release"
	dobin ${release}/ac++
	dobin ${release}/ag++
}
