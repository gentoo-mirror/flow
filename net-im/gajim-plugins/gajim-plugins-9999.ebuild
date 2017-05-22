# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Gajim plugins"
HOMEPAGE="https://dev.gajim.org/gajim/gajim-plugins/wikis/"

inherit git-r3
EGIT_REPO_URI="https://dev.gajim.org/gajim/gajim-plugins.git"

if [[ "${PV}" = "9999" ]] ; then
	KEYWORDS=""
else
#	EGIT_COMMIT="5a6d4d2679da188cae0323579c6ac9fa9b5a8dc9"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

#TODO:
DEPEND=""

RDEPEND="${DEPEND}"

BLACKLIST=("plugin_installer" "omemo" )

src_install() {
	local PLUGIN_DIR="/usr/share/gajim/plugins"
	dodir "${PLUGIN_DIR}"
	for plugindir in "${S}"/* ; do
		plugin="$(basename ${plugindir})"
		if echo "${BLACKLIST[@]}" | grep -v -q "${plugin}" ; then
		    elog installing ${plugin}
			cp -pPR "${plugindir}" "${D}/${PLUGIN_DIR}" || die "Installing ${plugin} failed"
		else
			elog skipping ${plugin}
		fi
	done
}
