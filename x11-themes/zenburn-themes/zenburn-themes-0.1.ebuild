# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="A GTK theme based on Zenburn"
HOMEPAGE="https://github.com/Flowdalic/zenburn-themes"
SRC_URI="mirror://github/Flowdalic/${PN}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	>=x11-themes/gtk-engines-murrine-0.98.2"

S="${WORKDIR}"

