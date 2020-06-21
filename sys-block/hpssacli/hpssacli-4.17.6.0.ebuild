# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

MY_PV=$(ver_rs 2 '-')

DESCRIPTION="HPE Smart Storage Administrator (HPE SSA) CLI (HPSSACLI, formerly HPACUCLI)"
HOMEPAGE="https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_9697c6899a664d02b9c3436674"
SRC_URI="https://downloads.linux.hpe.com/SDR/repo/spp/2020.03.0/packages/ssacli-${MY_PV}.x86_64.rpm"

LICENSE="hpe"
SLOT="0"
KEYWORDS="-* ~amd64"

S="${WORKDIR}"

src_unpack() {
	rpm_src_unpack
}

src_install() {
	readonly ssacli_bindir="${WORKDIR}/opt/smartstorageadmin/ssacli/bin"

	dobin "${ssacli_bindir}"/ssacli
	dobin "${ssacli_bindir}"/ssascripting

	dodoc "${ssacli_bindir}"/ssacli.license
	dodoc "${ssacli_bindir}/ssacli-${MY_PV}.x86_64.txt"

	gunzip usr/man/man8/ssacli.8.gz
	doman usr/man/man8/ssacli.8
}
