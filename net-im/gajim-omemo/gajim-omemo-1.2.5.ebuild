# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Gajim plugin for XEP proposal: OMEMO Encryption"
HOMEPAGE="https://dev.gajim.org/gajim/gajim-plugins/wikis/OmemoGajimPlugin"

inherit git-r3
EGIT_REPO_URI="https://dev.gajim.org/gajim/gajim-plugins.git"

if [[ "${PV}" = "9999" ]] ; then
	KEYWORDS=""
else
	EGIT_COMMIT="5a6d4d2679da188cae0323579c6ac9fa9b5a8dc9"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/python-axolotl
		dev-python/qrcode
		dev-python/cryptography"

RDEPEND="${DEPEND}"

src_install() {
	local PLUGIN_DIR="/usr/share/gajim/plugins"
	local OMEMO_PLUGIN_DIR="${PLUGIN_DIR}/omemo"
	dodir "${PLUGIN_DIR}"
	dodir "${OMEMO_PLUGIN_DIR}"
	cp -pPR "${S}"/omemo/* "${D}/${OMEMO_PLUGIN_DIR}" || die "Installing files failed"
}
