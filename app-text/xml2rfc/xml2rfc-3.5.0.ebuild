# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="generates RFCs and IETF drafts from document source in XML"
HOMEPAGE="https://pypi.python.org/pypi/xml2rfc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

# Tests are disabled because xml2rfc's test suite perform network
# operations: It tries to download resources from ietf.org. For
# example:
# Error: Failure fetching URL
# https://xml2rfc.ietf.org/public/rfc/bibxml/reference.RFC.2119.xml
# (HTTPSConnectionPool(host='xml2rfc.ietf.org', port=443): Max retries
# exceeded with url: /public/rfc/bibxml/reference.RFC.2119.xml (Caused
# by NewConnectionError('<urllib3.connection.HTTPSConnection object at
# 0x7f1911443150>: Failed to establish a new connection: [Errno -3]
# Temporary failure in name resolution')))
# See also https://trac.tools.ietf.org/tools/xml2rfc/trac/ticket/561
#IUSE="test"
RESTRICT="!test? ( test )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/PyPDF2[${PYTHON_USEDEP}]
		dev-python/decorator[${PYTHON_USEDEP}]
		dev-python/dict2xml[${PYTHON_USEDEP}]
		dev-python/weasyprint[${PYTHON_USEDEP}]
		media-fonts/noto[cjk]
	)
"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/configargparse[${PYTHON_USEDEP}]
	dev-python/intervaltree[${PYTHON_USEDEP}]
	dev-python/google-i18n-address[${PYTHON_USEDEP}]
	>=dev-python/html5lib-1.0.1[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	~dev-python/kitchen-1.2.6[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pycountry[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3.1[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

distutils_enable_tests setup.py
