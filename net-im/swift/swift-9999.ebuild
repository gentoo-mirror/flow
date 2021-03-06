# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

LANGS="ca de es fr hu nl pl ru se sk"

[[ ${PV} = *9999* ]] && VCS_ECLASS="git-r3" || VCS_ECLASS=""

inherit multilib toolchain-funcs linux-info scons-utils ${VCS_ECLASS} versionator

MY_PN="swift"
MY_PV=$(replace_version_separator 2 '')
MY_P="${MY_PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Your friendly chat client"
HOMEPAGE="http://swift.im/"
if [[ ${PV} == *9999* ]] ; then
	EGIT_REPO_URI="git://swift.im/swift"
else
	SRC_URI="http://swift.im/downloads/releases/${MY_P}/${MY_P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} == *9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

# TODO qt4?
IUSE="debug doc examples +expat +qt5 ssl static-libs zeroconf"

for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

RDEPEND="
	dev-libs/boost
	expat? ( dev-libs/expat )
	!expat? ( dev-libs/libxml2 )
	ssl? ( dev-libs/openssl )
	zeroconf? ( net-dns/avahi )
	net-dns/libidn
	sys-libs/zlib
	qt5? (
		x11-libs/libXScrnSaver
	)
"
DEPEND="${RDEPEND}
	doc? (
		>=app-text/docbook-xsl-stylesheets-1.75
		>=app-text/docbook-xml-dtd-4.5
		dev-libs/libxslt
	)
"
scons_targets=()
set_scons_targets() {
	scons_targets=( Swiften Sluift )
	use qt5 && scons_targets+=( Swift )
	use zeroconf && scons_targets+=( Slimber )
	use examples && scons_targets+=(
		Documentation/SwiftenDevelopersGuide/Examples
		Limber
		Swiften/Config
		Swiften/Examples
		Swiften/QA
		SwifTools
	)
}

scons_vars=()
set_scons_vars() {
	scons_vars=(
		V=1
		allow_warnings=1
		cc="$(tc-getCC)"
		cxx="$(tc-getCXX)"
		ccflags="${CXXFLAGS}"
		linkflags="${LDFLAGS}"
		openssl="${EPREFIX}/usr"
		docbook_xsl="${EPREFIX}/usr/share/sgml/docbook/xsl-stylesheets"
		docbook_xml="${EPREFIX}/usr/share/sgml/docbook/xml-dtd-4.5"
		$(use_scons debug)
		$(use !static-libs && use_scons !static-libs swiften_dll)
		$(use_scons ssl openssl)
		$(use zeroconf)
	)
}

src_prepare() {
	# Unbundle
	cd 3rdParty || die
	# TODO CppUnit, Lua
	rm -rf Boost CAres DocBook Expat LCov LibIDN OpenSSL SCons SQLite ZLib || die
	cd .. || die

	for x in ${LANGS}; do
		if use !linguas_${x}; then
			rm -f Swift/Translations/swift_${x}.ts || die
		fi
	done

	# Richard H. <chain@rpgfiction.net> (2012-03-29): SCons ignores us,
	# just delete unneeded stuff!
	if use !zeroconf; then
		rm -rf Slumber || die
	fi

	if use !examples; then
		rm -rf Documentation/SwiftenDevelopersGuide/Examples \
                Swiften/Examples \
                Swiften/QA \
                Swiftob || die
	fi

	if use !qt5; then
		rm -rf Swift || die
	fi

	# sed -i BuildTools/SCons/Tools/qt4.py \
	# 	-e "s/linux2/linux${KV_MAJOR}/" \
	# 	|| die
}

src_compile() {
	set_scons_targets
	set_scons_vars

	escons "${scons_vars[@]}" "${scons_targets[@]}"
}

src_test() {
	set_scons_targets
	set_scons_vars

	escons "${scons_vars[@]}" test=unit QA
}

src_install() {
	set_scons_targets
	set_scons_vars

	escons "${scons_vars[@]}" SWIFT_INSTALLDIR="${D}/usr" SWIFTEN_INSTALLDIR="${D}/usr" "${D}" "${scons_targets[@]}"
	dobin Sluift/sluift

	if use zeroconf ; then
		newbin Slimber/Qt/slimber slimber-qt
		newbin Slimber/CLI/slimber slimber-cli
	fi

	if use examples ; then
		for i in EchoBot{1,2,3,4,5,6} EchoComponent ; do
			newbin "Documentation/SwiftenDevelopersGuide/Examples/EchoBot/${i}" "${PN}-${i}"
		done

		dobin Limber/limber
		dobin Swiften/Config/swiften-config

		for i in BenchTool ConnectivityTest LinkLocalTool ParserTester SendFile SendMessage ; do
			newbin "Swiften/Examples/${i}/${i}" "${PN}-${i}"
		done
		newbin Swiften/Examples/SendFile/ReceiveFile "${PN}-ReceiveFile"
		use zeroconf && dobin Swiften/Examples/LinkLocalTool/LinkLocalTool

		for i in ClientTest NetworkTest StorageTest TLSTest ; do
			newbin "Swiften/QA/${i}/${i}" "${PN}-${i}"
		done

		newbin SwifTools/Idle/IdleQuerierTest/IdleQuerierTest ${PN}-IdleQuerierTest
	fi

	use doc && dohtml "Documentation/SwiftenDevelopersGuide/Swiften Developers Guide.html"
}
