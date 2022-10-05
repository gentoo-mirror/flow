# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for all the essential packages"
SLOT="0"
KEYWORDS="amd64"

IUSE="gui"
RDEPEND="
	app-admin/eclean-kernel
	app-admin/pwgen
	app-editors/emacs
	app-misc/tmux
	app-portage/cpuid2cpuflags
	app-portage/gentoolkit
	app-portage/mirrorselect
	app-shells/gentoo-zsh-completions
	app-shells/zsh
	dev-util/strace
	dev-vcs/git
	net-dns/bind-tools
	net-misc/mosh
	net-misc/unison
	sys-apps/dstat
	sys-apps/ethtool
	sys-apps/hwloc
	sys-apps/lshw
	sys-apps/ripgrep
	sys-apps/the_silver_searcher
	sys-fs/lvm2
	sys-fs/ncdu
	sys-process/lsof
	sys-process/htop
	gui? ( virtual/flow-gui-essential )
"
