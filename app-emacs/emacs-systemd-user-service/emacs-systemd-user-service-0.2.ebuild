# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Support for Emacs daemon using a systemd user service"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Emacs"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="app-editors/emacs"

S="${WORKDIR}"

src_install() {
	systemd_newuserunit - emacs.service <<EOF
[Unit]
Description=Emacs text editor
Documentation=info:emacs man:emacs(1) https://gnu.org/software/emacs/

[Service]
Type=notify
ExecStart=/usr/bin/emacs --fg-daemon
ExecStop=/usr/bin/emacsclient --eval "(kill-emacs)"
# The location of the SSH auth socket varies by distribution, and some
# set it from PAM, so don't override by default.
# Environment=SSH_AUTH_SOCK=%t/keyring/ssh
Restart=on-failure

[Install]
WantedBy=default.target
EOF
}
