# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils golang-build

EGO_PN="github.com/miekg/mmark"
MMARK_GITHUB_URL="https://${EGO_PN}"
DESCRIPTION="A markdown processor geared towards writing IETF documents"
HOMEPAGE="https://miek.nl/tags/mmark/ ${MMARK_GITHUB_URL}"
SRC_URI="${MMARK_GITHUB_URL}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="
	dev-lang/go
"

RDEPEND="${DEPEND}"

REL_MMARK_PATH="src/${EGO_PN}"

src_prepare() {
	eapply_user

	cp -r . ../tmp
	mkdir -p "${REL_MMARK_PATH}" || die
	mv ../tmp/* "${REL_MMARK_PATH}"

	export GOPATH="${S}:$(get_golibdir_gopath)"
	go get github.com/BurntSushi/toml
}

src_compile() {
	cd mmark || die

	export GOPATH="${S}:$(get_golibdir_gopath)"

	emake
}

src_install() {
	dobin ${PN}/${PN}
}
