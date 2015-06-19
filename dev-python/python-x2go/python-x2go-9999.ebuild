# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils git-2

DESCRIPTION="Python X2Go Client API"
HOMEPAGE="http://www.x2go.org"
SRC_URI=""
EGIT_REPO_URI="git://code.x2go.org/python-x2go.git"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/gevent
	dev-python/paramiko"
RDEPEND="${DEPEND}"
