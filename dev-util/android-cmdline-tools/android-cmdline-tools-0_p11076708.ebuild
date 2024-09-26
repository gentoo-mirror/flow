# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit greadme udev

DESCRIPTION="Open Handset Alliance's Android SDK"
HOMEPAGE="https://developer.android.com"
SRC_URI="
https://dl.google.com/android/repository/commandlinetools-linux-$(ver_cut 3)_latest.zip"

S="${WORKDIR}/cmdline-tools"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror"

DEPEND="acct-group/android"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

QA_PREBUILT="*"

src_install() {
	local android_sdk_dir="/opt/android-sdk"
	local android_sdk_latest_dir="${android_sdk_dir}/latest"

	insinto "${android_sdk_latest_dir}"
	doins -r .

	fowners -R root:android "${android_sdk_dir}"
	fperms -R 0775 "${android_sdk_dir}"

	newenvd - "80${PN}" <<-EOF
	PATH="${EPREFIX}${android_sdk_latest_dir}/bin"
	ANDROID_HOME="${EPREFIX}${android_sdk_dir}"
EOF

	# Rename from 80-android.rules to 80-android-device.rules to avoid
	# collision with dev-util/android-sdk-update-manager.
	udev_newrules "${FILESDIR}"/80-android.rules 80-android-device.rules

	greadme_stdin <<-EOF
	The Android SDK now uses its own manager for the development  environment.
	Run 'sdkmanager' to download the full SDK, including some of the platform tools.
	You must be in the android group to manage the development environment.
	Just run 'gpasswd -a <USER> android', then have <USER> re-login.
EOF
}
