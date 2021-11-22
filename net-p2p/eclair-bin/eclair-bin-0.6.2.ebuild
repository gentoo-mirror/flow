# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

ECLAIR_SHORT_COMMIT_ID="6817d6f"
ECLAIR_RELEASE_ID="${PV}-${ECLAIR_SHORT_COMMIT_ID}"

DESCRIPTION="Scala implemention of the Lightning Network"
HOMEPAGE="https://github.com/ACINQ/eclair"
SRC_URI="https://github.com/ACINQ/eclair/releases/download/v0.6.2/eclair-node-${ECLAIR_RELEASE_ID}-bin.zip -> eclair-${PV}.zip"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

S="${WORKDIR}/eclair-node-${ECLAIR_RELEASE_ID}"

BDEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.8:*"

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

	dosym "${eclair_dir}/bin/eclair-cli" "/usr/bin/eclair-cli"
	dosym "${eclair_dir}/bin/eclair-node.sh" "/usr/bin/eclair-node"

	systemd_dounit "${FILESDIR}/eclair_at.service" "eclair@.service"
}
