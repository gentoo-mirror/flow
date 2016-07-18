# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A set of C++ language extensions to facilitate aspect-oriented programming with C/C++"
HOMEPAGE="http://www.aspectc.org"
SRC_URI="bootstrap-aspectc++? ( http://aspectc.org/releases/${PV}/ac-${PV}.tar.gz )
	bootstrap-aspectc++? ( http://aspectc.org/releases/${PV}/ac-bin-linux-x86-64bit-2.1.tar.gz )"
#	!bootstrap-aspectc++? ( http://aspectc.org/releases/${PV}/ac-woven-${PV}.tar.gz )"

LICENSE=""
SLOT="0"
KEYWORDS=""
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
