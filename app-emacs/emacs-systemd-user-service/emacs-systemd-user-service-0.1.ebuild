# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Support for Emacs daemon using a systemd user service"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Emacs"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}"

src_install() {
	{
	cat <<EOF
[Unit]
Description=Emacs text editor
Documentation=info:emacs man:emacs(1) https://gnu.org/software/emacs/

[Service]
ExecStart=/bin/sh -c "source /etc/profile.env; exec /usr/bin/emacs --fg-daemon"
ExecStop=/usr/bin/emacsclient --eval "(kill-emacs)"
Restart=on-failure
SuccessExitStatus=15

[Install]
WantedBy=default.target
EOF
	} |	systemd_newuserunit - emacs.service
}
