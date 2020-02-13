# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A no-nonsense guide to Autotools"
HOMEPAGE="http://www.flameeyes.eu/autotools-mythbuster"
EGIT_REPO_URI="https://github.com/Flameeyes/autotools-mythbuster.git"

LICENSE="CC-BY-NC-SA-3.0"
SLOT="0"

# Disable network sandbox
# scss -t compressed --sourcemap=none stylesheets/mythbuster.scss public/stylesheets/mythbuster.css
# error : Invalid argument
# warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/chunk.xsl"
# compilation error: file stylesheets/flameeyes.eu.xsl line 9 element import
# xsl:import : unable to load http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/chunk.xsl
# make: *** [Makefile:10: public/index.html] Error 5
RESTRICT="network-sandbox"

BDEPEND="
	dev-ruby/sass
	dev-libs/libxslt
"

src_install() {
	docinto html
	dodoc -r public/
}
