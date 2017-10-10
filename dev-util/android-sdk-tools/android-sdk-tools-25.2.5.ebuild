# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils

DESCRIPTION="Open Handset Alliance's Android SDK Tools"
HOMEPAGE="http://developer.android.com"
SRC_URI="https://dl.google.com/android/repository/tools_r${PV}-linux.zip"
IUSE=""
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/gzip"
RDEPEND=">=virtual/jdk-1.5
	>=dev-java/ant-core-1.6.5
	sys-libs/zlib
	dev-util/android-sdk-support
"

ANDROID_SDK_DIR="/opt/android-sdk-update-manager"
QA_FLAGS_IGNORED_x86="
	${ANDROID_SDK_DIR/\/}/tools/emulator
	${ANDROID_SDK_DIR/\/}/tools/adb
	${ANDROID_SDK_DIR/\/}/tools/mksdcard
	${ANDROID_SDK_DIR/\/}/tools/sqlite3
	${ANDROID_SDK_DIR/\/}/tools/hprof-conv
	${ANDROID_SDK_DIR/\/}/tools/zipalign
	${ANDROID_SDK_DIR/\/}/tools/dmtracedump
"
QA_FLAGS_IGNORED_amd64="${QA_FLAGS_IGNORED_x86}"

QA_PREBUILT="${ANDROID_SDK_DIR/\/}/tools/*"

S="${WORKDIR}/tools"

src_prepare() {
	default_src_prepare
	rm -rd lib/x86* || die
}

src_install() {
	dodir "${ANDROID_SDK_DIR}/tools"
	cp -pPR * "${ED}${ANDROID_SDK_DIR}/tools" || die "failed to install tools"

	fowners -R root:android "${ANDROID_SDK_DIR}"/tools
	fperms -R 0775 "${ANDROID_SDK_DIR}"/tools
}
