# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

MY_PV=$(ver_rs 2 '-')

DESCRIPTION="HPE Smart Storage Administrator (HPE SSA) CLI (HPSSACLI, formerly HPACUCLI)"
HOMEPAGE="https://support.hpe.com/hpesc/public/swd/detail?swItemId=MTX_8484363847dd4e5ca2970188b7"
SRC_URI="https://downloads.hpe.com/pub/softlib2/software1/pubsw-linux/p1944765023/v183341/ssa-${MY_PV}.x86_64.rpm"

LICENSE="hpe"
SLOT="0"
KEYWORDS="-* ~amd64"

S="${WORKDIR}"

src_unpack() {
	rpm_src_unpack
}

src_install() {
	readonly ssacli_bindir="${WORKDIR}/opt/smartstorageadmin/ssa/bin"

	dobin "${ssacli_bindir}"/ssa
	dobin "${ssacli_bindir}"/ssaclient
	dobin "${ssacli_bindir}"/ssarequestor
	dobin "${ssacli_bindir}"/ssaresponder

	dodoc "opt/smartstorageadmin/ssa/ssa.license"

	gunzip usr/man/man8/ssa.8.gz
	doman usr/man/man8/ssa.8
}