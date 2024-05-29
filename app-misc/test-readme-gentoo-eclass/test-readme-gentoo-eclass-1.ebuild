# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

_GREADME_COMPRESS=true

inherit readme.gentoo-r1

DESCRIPTION="Test ebuild for the readme.gentoo-r1.eclass"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"

S="${WORKDIR}"

src_install() {
	readme.gentoo_stdin <<-EOF
	This is an example content of the readme file.

	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus posuere odio at auctor iaculis. In ornare et risus sed aliquet. Maecenas vitae nunc sed ligula hendrerit placerat quis vitae diam. Ut vel ligula aliquam, suscipit neque vitae, accumsan sem. Duis placerat porttitor blandit. Etiam sit amet erat et est imperdiet dictum. In id velit eu orci gravida rutrum sit amet in justo.
	EOF

	readme.gentoo_stdin --append <<-EOF
	This content was appended to the readme file.
	EOF
}
