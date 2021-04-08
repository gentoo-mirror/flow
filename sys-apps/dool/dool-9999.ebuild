# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit git-r3 python-r1

DESCRIPTION="Versatile replacement for vmstat, iostat and ifstat (clone of dstat)"
HOMEPAGE="https://github.com/scottchiefbaker/dool"
EGIT_REPO_URI="https://github.com/scottchiefbaker/dool.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
IUSE="doc examples"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

# PATCHES=(
# 	"${FILESDIR}/dstat-${PV}-skip-non-sandbox-tests.patch"
# 	"${FILESDIR}/fix-collections-deprecation-warning.patch"
# 	"${FILESDIR}/dstat-0.7.4-fix-csv-output.patch"
# )

# src_prepare() {

# 	# bug fix: allow delay to be specified
# 	# backport from: https://github.com/dagwieers/dstat/pull/167/files
# 	sed -i -e 's; / op\.delay; // op.delay;' "dstat" || die

# 	default
# }

src_compile() {
	:
}

src_install() {
	python_foreach_impl python_doscript "${PN}"

	insinto "/usr/share/${PN}"
	newins "${PN}" "${PN}.py"
	doins plugins/${PN}_*.py

	doman "docs/${PN}.1"

	einstalldocs

	if use examples; then
		dodoc examples/{mstat,read}.py
	fi
	if use doc; then
		dodoc docs/*.html
	fi
}

src_test() {
	python_foreach_impl emake test
}
