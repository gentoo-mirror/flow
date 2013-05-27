# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN=${PN%%-bin}

DESCRIPTION="File sync without servers."
HOMEPAGE="https://www.aerofs.com/"
SRC_URI="http://cache.client.aerofs.com/${MY_PN}-installer.tgz -> ${P}.tgz"
RESTRICT="mirror"

LICENSE="" # unknown
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-arch/sharutils
	virtual/jre
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/aerofs"

pkg_nofetch() {
	eerror "AeroFS does not use versioned filenames."
	eerror "An ebuild version bump is probably required."
	eerror ""
	eerror "Please see the following URL for the current version number:"
	eerror "http://support.aerofs.com/knowledgebase/articles/93285-release-notes"
}

src_prepare() {
	# see http://support.aerofs.com/forums/147816-linux-problems/suggestions/3578017-aerofs-and-arch-linux
	sed 's#uudecode -o /dev/stdout \$0 | tar xzf - -C \$TMP_DIR 2>/dev/null#(cd $TMP_DIR \&\& uudecode "$0" \&\& tar xzf bin -C . 2>/dev/null; rm bin)#' -i aerofs || die "uudecode sed failed"

	# see http://support.aerofs.com/forums/147816-linux-problems/suggestions/3135916-daemon-exited-with-code-127
	sed 's#^JRE_BASE=.*#JRE_BASE="$JAVA_HOME"#' -i aerofs || die "JRE_BASE sed failed"
}

src_install() {
	dobin "${MY_PN}"
	for t in cli gui sh; do
		dosym "${MY_PN}" "${DESTTREE}/bin/${PN}-${t}"
	done
}
