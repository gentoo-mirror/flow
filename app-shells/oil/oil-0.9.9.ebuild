# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A new Unix shell"
HOMEPAGE="https://www.oilshell.org/"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/oilshell/oil.git"
else
	SRC_URI="https://www.oilshell.org/download/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="readline"

DEPEND="readline? ( sys-libs/readline:= )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/oil-0.9.9-without-man.patch"
)

QA_PRESTRIPPED="usr/bin/oil.ovm"

src_configure() {
	econf \
		--without-man \
		$(use_with readline)
}

src_install() {
	default

	doman doc/osh.1
}
