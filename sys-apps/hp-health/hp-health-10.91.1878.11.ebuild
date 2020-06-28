# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd rpm

MY_PV=$(ver_rs 2 '-')

DESCRIPTION="HPE System Health Application and Command line Utilities (Gen9 and earlier)"
HOMEPAGE="https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX-c0104db95f574ae6be873e2064"
SRC_URI="http://downloads.linux.hpe.com/repo/spp/rhel/8Server/x86_64/2020.03.0/hp-health-${MY_PV}.rhel8.x86_64.rpm"

LICENSE="hpe"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror"

S="${WORKDIR}"

src_unpack() {
	rpm_unpack
}

src_install() {
	readonly my_sbins=(hpasmcli hpbootcfg hplog hpuid)
	for sb in "${my_sbins[@]}"; do
		dosbin sbin/${sb}
	done

	insinto /usr/lib/systemd/scripts
	doins usr/lib/systemd/scripts/hp-asrd.sh
	doins usr/lib/systemd/scripts/hp-health.sh

	systemd_dounit usr/lib/systemd/system/hp-asrd.service
	systemd_dounit usr/lib/systemd/system/hp-health.service

	local my_man=(
		hpasmcli.4
		hp-health.4
		hp_mgmt_install.7
		hp-asrd.8
		hpbootcfg.8
		hplog.8
		hpuid.8
	)
	for man in "${my_man[@]}"; do
		local section="${man##*.}"
		local rel_path="usr/share/man/man${section}/${man}"
		gunzip "${rel_path}.gz"
		doman "${rel_path}"
	done

	local opt_rel_path="opt/hp/hp-health"
	local hp_health_license="${opt_rel_path}/hp-health.license"
	dodoc "${hp_health_license}"
	# Remove the license file which we just installed via dodoc, since
	# we are going to install everything else in opt/hp/hp-health
	rm "${hp_health_license}"

	insinto "${opt_rel_path}"
	doins -r "${opt_rel_path}"

	insinto usr/lib64
	doins usr/lib64/*

	keepdir var/log/hp-health
	keepdir var/spool/hp-health
	keepdir var/spool/compaq
}
