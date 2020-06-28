# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd rpm

DESCRIPTION="HPE Agentless Management Service (Gen9 and earlier)"
HOMEPAGE="https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_fc4dd7fc1ce740d59f97f7cab9"
SRC_URI="http://downloads.linux.hpe.com/repo/spp/rhel/8Server/x86_64/2020.03.0/hp-ams-2.10.0-861.5.rhel8.x86_64.rpm"

LICENSE="hpe"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror"

S="${WORKDIR}"

src_unpack() {
	rpm_unpack
}

src_install() {
	dosbin sbin/amsHelper

	insinto /etc/sysconfig
	doins etc/sysconfig/hp-ams

	systemd_dounit usr/lib/systemd/system/hp-ams.service

	readonly amsHelperManPage="usr/share/man/man8/amsHelper.8"
	gunzip "${amsHelperManPage}".gz
	doman "${amsHelperManPage}"

	dodoc opt/hp/hp-ams/hp-ams.license
}
