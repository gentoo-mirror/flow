# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit user systemd

GITHUB_USER="syncthing"
GITHUB_REPO="syncthing"
GITHUB_TAG="${PV}"

NAME="syncthing"
DESCRIPTION="Open Source Continuous File Synchronization"
HOMEPAGE="http://syncthing.net/"

SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/archive/v${GITHUB_TAG}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-lang/go-1.4.2"

S="${WORKDIR}"

SYNCTHING_HOME="/var/lib/${PN}"

pkg_setup() {
	enewuser ${PN} -1 -1 "${SYNCTHING_HOME}"
}

src_install() {
	# Create directory structure recommended by SyncThing Documentation
	# Since Go is "very particular" about file locations.
	local newBaseDir="src/github.com/${PN}"
	local newWorkDir="${newBaseDir}/${PN}"

	mkdir -p "${newBaseDir}"
	mv "${P}" "${newWorkDir}"

	cd "${newWorkDir}"

	# Build SyncThing ;D
	go run build.go -version v${PV} -no-upgrade=true

	# Copy compiled binary over to image directory
	dobin "bin/${PN}"

	# Install the OpenRC init/conf files
	doinitd "${FILESDIR}/init.d/${NAME}"
	doconfd "${FILESDIR}/conf.d/${NAME}"

	# Install the systemd service files
	systemd_dounit "etc/linux-systemd/system/${PN}@.service"
	systemd_douserunit "etc/linux-systemd/user/${PN}.service"

	dodir "${SYNCTHING_HOME}"
	fowners $PN "${SYNCTHING_HOME}"
	fperms 700 "${SYNCTHING_HOME}"
}

pkg_postinst() {
	elog "In order to be able to view the Web UI remotely (from another machine),"
	elog "edit syncthing's config.xml (usually in ~/.config/syncthing) and change"
	elog "the 127.0.0.1:8080 to 0.0.0.0:8080 in the 'address' section."
	elog "This file will only be generated once you start syncthing."
}
