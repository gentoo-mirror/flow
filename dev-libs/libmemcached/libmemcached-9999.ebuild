# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib bzr

DESCRIPTION="a C client library to the memcached server"
HOMEPAGE="http://libmemcached.org"
SRC_URI=""
EBZR_REPO_URI="http://bazaar.launchpad.net/~branch/libmemcached/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~sparc-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug doc hsieh +memaslap static-libs tcmalloc"

DEPEND="net-misc/memcached
		virtual/perl-PodParser
		doc? ( dev-python/sphinx )
		dev-libs/libevent
		tcmalloc? ( dev-util/google-perftools )
		virtual/gsasl"
RDEPEND="${DEPEND}"

src_prepare() {
	# These tests freezes for me
	sed -i \
		-e "/connectionpool/d" \
		-e "/lp:583031/d" \
		tests/${P%.*}/mem_functions.cc || die
}

src_configure() {
	econf \
		--disable-dtrace \
		$(use_enable debug assert) \
		$(use_with debug debug) \
		$(use_enable hsieh hsieh_hash) \
		$(use_enable tcmalloc tcmalloc) \
		$(use_enable static-libs static) \
		$(use_enable memaslap memaslap)
}

src_compile() {
	emake || die

	if use doc; then
		emake html-local || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	use static-libs || rm -f "${D}"/usr/$(get_libdir)/lib*.la

	dodoc AUTHORS ChangeLog README THANKS TODO
	# remove manpage to avoid collision, see bug #299330
	rm -f "${D}"/usr/share/man/man1/memdump.* || die "Install failed"
	newman docs/man/memdump.1 memcached_memdump.1
	if use doc; then
		dohtml -r docs/html/* || die
	fi
}
