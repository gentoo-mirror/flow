# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit  git-r3

DESCRIPTION="xmpp component implementing XEP-0363 to upload and share files via http"
HOMEPAGE="https://github.com/siacs/HttpUploadComponent"
EGIT_REPO_URI="https://github.com/kalkin/gajim-omemo.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/python-axolotl"
RDEPEND="${DEPEND}"

src_install() {

#	distutils-r1_python_install
	local PLUGIN_DIR="/usr/share/gajim/plugins"
	local OMEMO_PLUGIN_DIR="${PLUGIN_DIR}/omemo"
	dodir "${PLUGIN_DIR}"
	dodir "${OMEMO_PLUGIN_DIR}"
	cp -pPR "${S}"/* "${D}/${OMEMO_PLUGIN_DIR}" || die "Installing files failed"
}
