# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Language for multithreaded parallel programming based on ANSI C"
HOMEPAGE="http://supertech.csail.mit.edu/cilk"
SRC_URI="https://www4.cs.fau.de/~flow/stuff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static-libs"

PATCHES=(
	"${FILESDIR}/${P}-autotools.patch"
)

src_prepare() {
	# fix #571060 by restoring pre-GCC5 inline semantics
	append-cflags -std=gnu89
	append-cppflags -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=200809L
	replace-flags -O[2-9] -O1

	default
	eautoreconf
}

src_configure() {
	econf \
		--with-perfctr=no \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS README THANKS
	use doc && dodoc doc/manual.pdf
	if use examples; then
		docinto /usr/share/doc/${PF}
		dodoc -r examples
	fi
}
