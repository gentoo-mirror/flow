# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Converts ANSI escape sequences of a unix terminal to HTML"
HOMEPAGE="https://github.com/theZiz/aha"
SRC_URI="https://github.com/theZiz/${PN}/archive/${PV}.tar.gz"

LICENSE="MPL-1.0 LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	einstalldocs
}
