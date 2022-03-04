# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small ACME client written with process isolation and minimal privileges in mind"
HOMEPAGE="https://git.guilhem.org/lacme/"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.guilhem.org/lacme"
else
	SRC_URI="https://dev.gentoo.org/~flow/distfiles/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	test? ( dev-util/schroot )
"

RDEPEND="
	acct-user/lacme
	dev-lang/perl
	dev-libs/openssl
	dev-perl/Config-Tiny
	dev-perl/JSON
	dev-perl/Net-SSLeay
	dev-perl/TimeDate
	dev-perl/libwww-perl
"

BDEPEND="
	app-misc/jq
	app-text/pandoc
"

src_prepare() {
	default

	# Zap the installation of the man pages via the Makefile.
	sed -i '/man[0-9]dir/d' Makefile || die
}

src_compile() {
	local emake_args=(
		datarootdir="/usr/share"
		exec_prefix="/usr"
		lacme_client_group="${PN}"
		lacme_client_user="${PN}"
	)
	emake ${emake_args[@]} ${LACME_EMAKE_ARGS[@]}
}

src_test() {
	./test || die
}

src_install() {
	local emake_args=(
		DESTDIR="${D}"
		datarootdir="${D}/usr/share"
		exec_prefix="${D}/usr"
	)
	emake install ${emake_args[@]}

	dodoc README Changelog
	doman build/lacme.8 build/lacme-accountd.1
}
