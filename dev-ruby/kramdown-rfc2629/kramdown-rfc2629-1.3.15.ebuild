# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="An RFC2629 (XML2RFC) backend for Thomas Leitner's kramdown markdown parser"
HOMEPAGE="https://github.com/cabo/kramdown-rfc2629"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/kramdown-1.17.0
	>=dev-ruby/certified-1.0.0"
