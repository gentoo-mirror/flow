# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ORIG_PV=$(ver_rs 3 -M)

DESCRIPTION="Java/Scala artifact fetching, bundling and deploying"
HOMEPAGE="https://get-coursier.io/"
SRC_URI="https://github.com/coursier/coursier/releases/download/v${ORIG_PV}/cs-x86_64-pc-linux.gz -> ${P}.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}"

RDEPEND="sys-libs/zlib"

QA_FLAGS_IGNORED="usr/bin/cs"
QA_TEXTRELS="usr/bin/cs"

src_install() {
	newbin "${P}" cs
}
