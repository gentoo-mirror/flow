# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils user udev

DESCRIPTION="Support files for the Android SDK"
HOMEPAGE="http://geekplace.eu"
SRC_URI=""
IUSE=""
RESTRICT="mirror"

# TODO: Select a better suited license, as android-sdk-support does
# not contain any code under the 'android' licsense.
LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}"

DEPEND=""
RDEPEND="!dev-util/android-sdk-update-manager"

ANDROID_SDK_DIR="/opt/android-sdk-update-manager"

pkg_setup() {
	enewgroup android
}

src_install(){
	echo "PATH=\"${EPREFIX}${ANDROID_SDK_DIR}/tools:${EPREFIX}${ANDROID_SDK_DIR}/platform-tools\"" > "${T}/80${PN}" || die

	SWT_PATH=
	SWT_VERSIONS="3.8 3.7"
	for version in $SWT_VERSIONS; do
		# redirecting stderr to /dev/null
		# not sure if this is best, but avoids misleading error messages
		SWT_PATH="`dirname \`java-config -p swt-\$version 2>/dev/null\` 2>/dev/null`"
		if [ $SWT_PATH ]; then
			einfo "SWT_PATH=$SWT_PATH selecting version $version of SWT."
			break
		fi
	done

	echo "ANDROID_SWT=\"${SWT_PATH}\"" >> "${T}/80${PN}" || die
	echo "ANDROID_HOME=\"${EPREFIX}${ANDROID_SDK_DIR}\"" >> "${T}/80${PN}" || die

	doenvd "${T}/80${PN}"

	echo "SEARCH_DIRS_MASK=\"${EPREFIX}${ANDROID_SDK_DIR}\"" > "${T}/80${PN}" || die

	insinto "/etc/revdep-rebuild" && doins "${T}/80${PN}"

	udev_dorules "${FILESDIR}"/80-android.rules || die
}
