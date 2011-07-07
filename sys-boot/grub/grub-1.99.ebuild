# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ ${PV} == "9999" ]] ; then
	EBZR_REPO_URI="http://bzr.savannah.gnu.org/r/grub/trunk/grub/"
	LIVE_ECLASS="autotools bzr"
	SRC_URI=""
else
	MY_P=${P/_/\~}
	SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.xz
		mirror://gentoo/${MY_P}.tar.xz"
	S=${WORKDIR}/${MY_P}
fi

inherit mount-boot eutils flag-o-matic toolchain-funcs ${LIVE_ECLASS}
unset LIVE_ECLASS

DESCRIPTION="GNU GRUB boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"

LICENSE="GPL-3"
SLOT="2"
[[ ${PV} != "9999" ]] && KEYWORDS="~amd64 ~x86 ~mips ~ppc ~ppc64"
IUSE="custom-cflags debug device-mapper nls static sdl truetype"

GRUB_PLATFORMS="coreboot efi-32 efi-64 emu ieee1275 multiboot pc qemu qemu-mips yeeloong"
# everywhere:
#     emu
# mips only:
#     qemu-mips, yeelong
# amd64, x86, ppc, ppc64
#     ieee1275
# amd64, x86
#     coreboot, multiboot, efi-32, pc, qemu
# amd64
#     efi-64
for i in ${GRUB_PLATFORMS}; do
	IUSE+=" grub_platforms_${i}"
done
unset i

# os-prober: Used on runtime to detect other OSes
# xorriso (dev-libs/libisoburn): Used on runtime for mkrescue
RDEPEND="
	dev-libs/libisoburn
	dev-libs/lzo
	sys-boot/os-prober
	>=sys-libs/ncurses-5.2-r5
	debug? (
		sdl? ( media-libs/libsdl )
	)
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	truetype? ( media-libs/freetype >=media-fonts/unifont-5 )"
DEPEND="${RDEPEND}
	>=dev-lang/python-2.5.2
"
if [[ ${PV} == "9999" ]]; then
	DEPEND+=" >=sys-devel/autogen-5.10 sys-apps/help2man"
else
	DEPEND+=" app-arch/xz-utils"
fi

export STRIP_MASK="*/grub/*/*.{mod,img}"
QA_EXECSTACK="
	lib64/grub/*/setjmp.mod
	lib64/grub/*/kernel.img
	sbin/grub2-probe
	sbin/grub2-setup
	sbin/grub2-mkdevicemap
	bin/grub2-script-check
	bin/grub2-fstest
	bin/grub2-mklayout
	bin/grub2-menulst2cfg
	bin/grub2-mkrelpath
	bin/grub2-mkpasswd-pbkdf2
	bin/grub2-mkfont
	bin/grub2-editenv
	bin/grub2-mkimage
"

grub_run_phase() {
	local phase=$1
	local platform=$2
	[[ -z ${phase} ]] && die "${FUNCNAME}: Phase is undefined"
	[[ -z ${platform} ]] && die "${FUNCNAME}: Platform is undefined"

	[[ -d "${WORKDIR}/build-${platform}" ]] || \
		{ mkdir "${WORKDIR}/build-${platform}" || die ; }
	pushd "${WORKDIR}/build-${platform}" > /dev/null || die

	echo ">>> Running ${phase} for platform \"${platform}\""
	echo ">>> Working in: \"${WORKDIR}/build-${platform}\""

	grub_${phase} ${platform}

	popd > /dev/null || die
}

grub_rename_files() {
	# specifies if we do sed work too
	local deep=$1
	[[ ${deep} == deep ]] && shift || deep=""
	local path=$@

	[[ -z ${path} ]] && die "${FUNCNAME}: Path is undefined"

	pushd "${path}" > /dev/null
	for i in grub*; do
		echo ">>> Slotting \"${path}/${i}\" to \"${path}/${i/grub/grub2}\""
		if [[ -n $deep ]]; then
			sed -i \
				-e 's:\([[:space:]]\+\)grub-:\1grub2-:g' \
				${i} || die
		fi
		mv ${i} ${i/grub/grub2} || die
	done
	popd > /dev/null
}

grub_src_configure() {
	local platform=$1
	local target

	[[ -z ${platform} ]] && die "${FUNCNAME}: Platform is undefined"

	# if we have no platform then --with-platform=guessed does not work
	[[ ${platform} == "guessed" ]] && platform=""

	# check if we have to specify the target (EFI)
	# or just append correct --with-platform
	if [[ -n ${platform} ]]; then
		if [[ ${platform} == efi* ]]; then
			# EFI platform hack
			[[ ${platform/*-} == 32 ]] && target=i386
			[[ ${platform/*-} == 64 ]] && target=x86_64
			# program-prefix is required empty because otherwise it is equal to
			# target variable, which we do not want at all
			platform="
				--with-platform=${platform/-*}
				--target=${target}
				--program-prefix=
			"
		else
			platform=" --with-platform=${platform}"
		fi
	fi

	ECONF_SOURCE="${WORKDIR}/${P}/" \
	econf \
		--disable-werror \
		--sbindir=/sbin \
		--bindir=/bin \
		--libdir=/$(get_libdir) \
		--disable-efiemu \
		$(use_enable device-mapper) \
		$(use_enable truetype grub-mkfont) \
		$(use_enable nls) \
		$(use_enable debug mm-debug) \
		$(use sdl && use_enable debug grub-emu-sdl) \
		$(use_enable debug grub-emu-usb) \
		${platform}
}

grub_src_compile() {
	default_src_compile
}

grub_src_install() {
	default_src_install
}

src_prepare() {
	local i j archs

	epatch_user

	# autogen.sh does more than just run autotools
	if [[ ${PV} == "9999" ]] ; then
		sed -i -e '/^autoreconf/ d' autogen.sh || die
		(. ./autogen.sh) || die
		eautoreconf
	fi

	# get enabled platforms
	GRUB_ENABLED_PLATFORMS=""
	for i in ${GRUB_PLATFORMS}; do
		use grub_platforms_${i} && GRUB_ENABLED_PLATFORMS+=" ${i}"
	done
	[[ -z ${GRUB_ENABLED_PLATFORMS} ]] && GRUB_ENABLED_PLATFORMS="guessed"
	einfo "Going to build following platforms: ${GRUB_ENABLED_PLATFORMS}"
}

src_configure() {
	local i

	use custom-cflags || unset CFLAGS CPPFLAGS LDFLAGS
	use static && append-ldflags -static

	for i in ${GRUB_ENABLED_PLATFORMS}; do
		grub_run_phase ${FUNCNAME} ${i}
	done
}

src_compile() {
	local i

	for i in ${GRUB_ENABLED_PLATFORMS}; do
		grub_run_phase ${FUNCNAME} ${i}
	done
}

src_install() {
	local i

	for i in ${GRUB_ENABLED_PLATFORMS}; do
		grub_run_phase ${FUNCNAME} ${i}
	done

	# Slot all binaries/info/man to state grub2-* instead of grub-*.
	# Can this be done better?
	grub_rename_files "${ED}"/sbin/
	grub_rename_files "${ED}"/bin/
	grub_rename_files deep "${ED}"/usr/share/info/
#	grub_rename_files deep "${ED}"/usr/share/man/man1/
#	grub_rename_files deep "${ED}"/usr/share/man/man8/
	# Rename direct binaries calls in the bash scripts provided by grub
	dosym /lib64/grub/grub-mkconfig_lib /lib64/grub/grub2-mkconfig_lib
	sed -i \
		-e 's:echo grub-:echo grub2-:' \
		"${ED}"/{sbin,bin,lib64/grub}/*
	sed -i \
		-e 's:grub-:grub2-:'
		"${ED}"/etc/grub.d/*

	# can't be in docs array as we use defualt_src_install in different builddir
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	insinto /etc/default
	newins "${FILESDIR}"/grub.default grub
	cat <<-EOF >> "${D}"/lib*/grub/grub-mkconfig_lib
	GRUB_DISTRIBUTOR="Gentoo"
EOF
}

setup_boot_dir() {
	local dir=$1

	if [[ ! -e ${dir}/grub.cfg ]]; then
		# display the link to guide if user didn't set up anything yet.
		elog "For informations how to configure grub-2 please reffer to guide:"
		# FIXME: we don't have any guide yet!
		# Lets just use archlinux wiki until we have some.
		elog "    https://wiki.archlinux.org/index.php/GRUB2"
	fi

	if [[ ! -e ${dir}/grub.cfg && -e ${dir}/menu.lst ]] ; then
		# This is first grub2 install and we have old configuraton for
		# grub1 around. Lets try to generate grub.cfg from it so user
		# does not loose any stuff when rebooting.
		# NOTE: in long term he still NEEDS to migrate to grub.d stuff.
		einfo "Running: grub2-menulst2cfg '${dir}/menu.lst' '${dir}/grub.cfg'"
		grub2-menulst2cfg "${dir}/menu.lst" "${dir}/grub.cfg" || \
			ewarn "Running grub2-menulst2cfg failed!"

		einfo "Even if we just created configuration for your grub-2 using old"
		einfo "grub-1 configuration file you should migrate to use new style"
		einfo "configuration in '${ROOT}/etc/grub.d'."
		einfo

	else
		# we need to refresh the grub.cfg everytime just to play it safe
		einfo "Running: grub2-mkconfig -o '${dir}/grub.cfg'"
		grub2-mkconfig -o "${dir}/grub.cfg" || \
			ewarn "Running grub2-mkconfig failed! Check your configuration files!"
	fi

	elog "Remember to run \"grub2-mkconfig -o '${dir}/grub.cfg'\" every time"
	elog "you update the configuration files!"

	elog "Remember to run grub2-install to install your grub every time"
	elog "you update this package!"
}

pkg_postinst() {
	mount-boot_mount_boot_partition

	setup_boot_dir "${ROOT}"boot/grub

	# needs to be called after we call setup_boot_dir
	mount-boot_pkg_postinst
}
