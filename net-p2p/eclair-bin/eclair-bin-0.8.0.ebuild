# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

ECLAIR_SHORT_COMMIT_ID="0077471"
ECLAIR_RELEASE_ID="${PV}-${ECLAIR_SHORT_COMMIT_ID}"

DESCRIPTION="Scala implemention of the Lightning Network"
HOMEPAGE="https://github.com/ACINQ/eclair"
SRC_URI="https://github.com/ACINQ/eclair/releases/download/v${PV}/eclair-node-${ECLAIR_RELEASE_ID}-bin.zip -> eclair-${PV}.zip"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/eclair-node-${ECLAIR_RELEASE_ID}"

BDEPEND="app-arch/unzip"
RDEPEND="
	app-misc/jq
	>=virtual/jre-1.8:*
"

src_prepare() {
	default
	rm bin/eclair-node.bat || die
	rm LICENSE || die
}

src_install() {
	dodoc README.md

	local eclair_dir="/opt/eclair"

	insinto "${eclair_dir}"
	doins -r bin/ lib/
	fperms -R 755 "${eclair_dir}/bin"

	dosym "${eclair_dir}/bin/eclair-cli" "/usr/bin/eclair-cli"
	dosym "${eclair_dir}/bin/eclair-node.sh" "/usr/bin/eclair-node"

	systemd_newunit "${FILESDIR}/eclair_at.service" "eclair@.service"
}
