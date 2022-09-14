# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Run gitlab pipelines locally as shell executor or docker executor"
HOMEPAGE="https://github.com/firecow/gitlab-ci-local"
SRC_URI="https://github.com/firecow/gitlab-ci-local/releases/download/${PV}/linux.gz -> ${P}.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

QA_PREBUILT="usr/bin/gitlab-ci-local"

src_compile() {
	:
}

src_install() {
	newbin ${P} gitlab-ci-local
}
