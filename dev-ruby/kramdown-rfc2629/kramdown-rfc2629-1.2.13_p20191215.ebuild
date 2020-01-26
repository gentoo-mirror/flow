# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby24 ruby25 ruby26"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit git-r3 ruby-fakegem

DESCRIPTION="An RFC2629 (XML2RFC) backend for Thomas Leitner's kramdown markdown parser"
HOMEPAGE="https://github.com/cabo/kramdown-rfc2629"

SRC_URI=""
EGIT_REPO_URI="https://github.com/cabo/kramdown-rfc2629.git"
EGIT_COMMIT="9912b59686bedc55aad5a8f8764f821c5638b82a"
EGIT_CHECKOUT_DIR="${WORKDIR}/all"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64"
IUSE=""

ruby_add_rdepend "dev-ruby/kramdown"

all_ruby_unpack() {
	git-r3_src_unpack
}
