# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1 git-r3 udev

DESCRIPTION="Automatically select a display configuration based on connected devices"
HOMEPAGE="https://github.com/phillipberndt/autorandr"
EGIT_REPO_URI="https://github.com/phillipberndt/${PN}.git"
EGIT_COMMIT_ID="ee77c355294c596c29a78b10a625d3db1a8ab1d5"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion pm-utils systemd udev"

DEPEND="
	virtual/pkgconfig
	${RDEPEND}
"
RDEPEND="
	bash-completion? ( app-shells/bash )
	pm-utils? ( sys-power/pm-utils )
	systemd? ( sys-apps/systemd )
	udev? ( virtual/udev )
"

src_install() {
	targets="autorandr autostart_config"
	if use pm-utils; then
		targets="$targets pmutils"
	fi
	if use systemd; then
		targets="$targets systemd"
	fi
	if use udev; then
		targets="$targets udev"
	fi

	emake DESTDIR="${D}" install TARGETS="$targets"

	# We do not use autorandr's bash_completion target, since it would
	# install the bash completion file in the wrong directory:
	# /etc/bash_completion.d instead of /usr/share/bash-completion/
	# So instead use bash-completion.eclass's newbashcomp.
	if use bash-completion; then
		newbashcomp contrib/bash_completion/${PN} ${PN}
	fi
}

pkg_postinst() {
	if use udev; then
		udev_reload
	fi
}
