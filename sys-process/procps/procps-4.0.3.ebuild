# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic multilib-minimal usr-ldscript

DESCRIPTION="Standard informational utilities and process-handling tools"
HOMEPAGE="http://procps-ng.sourceforge.net/ https://gitlab.com/procps-ng/procps"
SRC_URI="mirror://sourceforge/${PN}-ng/${PN}-ng-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="ng/0" # libproc2.so
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="elogind +kill modern-top +ncurses nls selinux static-libs systemd test unicode"
RESTRICT="!test? ( test )"

DEPEND="
	elogind? ( sys-auth/elogind )
	ncurses? ( >=sys-libs/ncurses-5.7-r7:=[unicode(+)?] )
	selinux? ( sys-libs/libselinux[${MULTILIB_USEDEP}] )
	systemd? ( sys-apps/systemd:=[${MULTILIB_USEDEP}] )
"
BDEPEND="
	elogind? ( virtual/pkgconfig )
	ncurses? ( virtual/pkgconfig )
	systemd? ( virtual/pkgconfig )
	test? ( dev-util/dejagnu )
"
RDEPEND="${DEPEND}
	kill? (
		!sys-apps/coreutils[kill]
		!sys-apps/util-linux[kill]
	)
	!<sys-process/procps-4
	!<app-i18n/man-pages-l10n-4.2.0-r1
	!<app-i18n/man-pages-de-2.12-r1
	!<app-i18n/man-pages-pl-0.7-r1
"

S="${WORKDIR}/${PN}-ng-${PV%_*}"

# https://bugs.gentoo.org/898830
QA_CONFIG_IMPL_DECL_SKIP=( makedev )

PATCHES=(
	# bug 583036, https://gitlab.com/procps-ng/procps/-/merge_requests/197
	"${FILESDIR}"/${PN}-4.0.3-proc-tests.patch
)

multilib_src_configure() {
	# http://www.freelists.org/post/procps/PATCH-enable-transparent-large-file-support
	append-lfs-flags #471102

	local myeconfargs=(
		$(multilib_native_use_with elogind) # No elogind multilib support
		$(multilib_native_use_enable kill)
		$(multilib_native_use_enable modern-top)
		$(multilib_native_use_with ncurses)
		$(use_enable nls)
		$(use_enable selinux libselinux)
		$(use_enable static-libs static)
		$(use_with systemd)
		$(use_enable unicode watch8bit)
	)
	# bug #794997
	if use elibc_musl; then
		myeconfargs+=( --disable-w )
	fi
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_test() {
	emake check </dev/null #461302
}

multilib_src_install() {
	default
	dodoc "${S}"/sysctl.conf

	if multilib_is_native_abi ; then
		dodir /bin
		mv "${ED}"/usr/bin/ps "${ED}"/bin/ || die
		if use kill ; then
			mv "${ED}"/usr/bin/kill "${ED}"/bin/ || die
		fi

		gen_usr_ldscript -a proc2
	fi
}

multilib_src_install_all() {
	einstalldocs
	find "${ED}" -type f -name '*.la' -delete || die
}
