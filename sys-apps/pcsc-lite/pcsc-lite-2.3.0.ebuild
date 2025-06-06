# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit autotools greadme python-single-r1 systemd tmpfiles udev multilib-minimal

DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="https://pcsclite.apdu.fr https://github.com/LudovicRousseau/PCSC"
SRC_URI="https://pcsclite.apdu.fr/files/${P}.tar.xz"

# GPL-2 is there for the init script; everything else comes from
# upstream.
LICENSE="BSD BSD-2 ISC GPL-2 GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
# This is called libusb so that it doesn't fool people in thinking that
# it is _required_ for USB support. Otherwise they'll disable udev and
# that's going to be worse.
IUSE="doc embedded libusb policykit selinux systemd +udev"
REQUIRED_USE="^^ ( udev libusb ) ${PYTHON_REQUIRED_USE}"

# No dependencies need the MULTILIB_DEPS because the libraries are actually
# standalone, the deps are only needed for the daemon itself.
DEPEND="
	libusb? ( virtual/libusb:1 )
	udev? ( virtual/libudev:= )
	policykit? ( >=sys-auth/polkit-0.111 )
	acct-group/openct
	acct-group/pcscd
	acct-user/pcscd
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-pcscd )"
BDEPEND="
	app-alternatives/lex
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-1.9.8-systemd-user.patch
)

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		--disable-maintainer-mode \
		--disable-strict \
		--enable-usbdropdir="${EPREFIX}"/usr/$(get_libdir)/readers/usb \
		--enable-ipcdir=/run/pcscd \
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)" \
		$(multilib_native_use_enable doc documentation) \
		$(multilib_native_use_enable embedded) \
		$(multilib_native_use_enable systemd libsystemd) \
		$(multilib_native_use_enable udev libudev) \
		$(multilib_native_use_enable libusb) \
		$(multilib_native_use_enable policykit polkit)
}

multilib_src_install_all() {
	einstalldocs
	dodoc HELP SECURITY

	newinitd "${FILESDIR}"/pcscd-init.7 pcscd
	dotmpfiles "${FILESDIR}"/pcscd.conf

	if use udev; then
		exeinto "$(get_udevdir)"
		newexe "${FILESDIR}"/pcscd-udev pcscd.sh

		insinto "$(get_udevdir)"/rules.d
		newins "${FILESDIR}"/99-pcscd-hotplug-r2.rules 99-pcscd-hotplug.rules
	fi

	python_fix_shebang "${ED}"/usr/bin/pcsc-spy

	find "${ED}" -name '*.la' -delete || die
}

src_install() {
	multilib-minimal_src_install

	greadme_stdin <<-EOF
	Starting from version 1.6.5, pcsc-lite will start as user nobody in
	the pcscd group, to avoid running as root.

	This also means you need the newest drivers available so that the
	devices get the proper owner.

	Furthermore, a conf.d file is no longer installed by default, as
	the default configuration does not require one. If you need to
	pass further options to pcscd, create a file and set the
	EXTRA_OPTS variable.
EOF
	if use udev; then
		greadme_stdin --append <<-EOF

		Hotplug support is provided by udev rules.
		When using OpenRC you additionally need to tell it to hotplug
		pcscd by setting this variable in /etc/rc.conf:

		rc_hotplug="pcscd"
EOF
	fi
}

pkg_postinst() {
	greadme_pkg_postinst

	tmpfiles_process pcscd.conf

	use udev && udev_reload
}

pkg_postrm() {
	use udev && udev_reload
}
