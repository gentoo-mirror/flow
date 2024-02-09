# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

MY_PN=${PN%-bin}
MY_P=${MY_PN}-${PV}

DESCRIPTION="An open-source automation software for your home"
HOMEPAGE="https://www.openhab.org/"
SRC_URI="https://github.com/openhab/openhab-distro/releases/download/${PV}/${MY_P}.zip"
KEYWORDS="~amd64"

LICENSE="EPL-2.0"
SLOT="0"

MY_JAVA_DEPEND=">=virtual/jre-17"

RDEPEND="
	${MY_JAVA_DEPEND}
	acct-user/openhab
	dev-java/java-config
"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_compile() {
	:
}

src_install() {
	# We use move here to preserve the executable bit on the files under
	# openhab/runtime/bin.
	domove() {
		local source="${1}"
		local target="${2}"

		local dest="${ED}/${target}"

		mkdir -p "${dest}" || die "Failed to create ${dest}"
		mv "${source}"/* "${dest}" || die "Failed to move"
	}

	domove runtime /usr/share/openhab/runtime
	domove conf /etc/openhab

	domove userdata /var/lib/openhab
	fowners -R openhab:openhab /var/lib/openhab

	local dirs=(
		/usr/share/openhab/addons
		/var/log/openhab
	)
	local d
	for d in "${dirs[@]}"; do
		keepdir "${d}"
		fowners openhab:openhab "${d}"
	done

	systemd_dounit "${FILESDIR}"/openhab.service

	newbin - openhab <<EOF
#!/usr/bin/env bash
set -eu

if [[ -v JAVA_HOME_OVERRIDE ]]; then
	JAVA_HOME="\${JAVA_HOME_OVERRIDE}"
else
	if ! GENTOO_JAVA_VM="\$(depend-java-query --get-vm '${MY_JAVA_DEPEND}')"; then
		>&2 echo "Could not find Java VM for ${MY_JAVA_DEPEND}"
	exit 1
	fi

	if ! JAVA_HOME_ASSIGNMENT=\$(java-config -P \${GENTOO_JAVA_VM} | grep JAVA_HOME); then
		>&2 echo "Could not retrieve JAVA_HOME of \${GENTOO_JAVA_VM}"
		exit 1
	fi

	eval \${JAVA_HOME_ASSIGNMENT}
fi

export JAVA_HOME
exec /usr/share/openhab/runtime/bin/karaf "\$@"
EOF
}
