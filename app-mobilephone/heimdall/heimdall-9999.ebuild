EAPI="2"

inherit autotools eutils qt4-r2 git-2

DESCRIPTION="Heimdall is a cross-platform open-source tool suite used to flash firmware (aka ROMs) onto Samsung Galaxy S devices."
HOMEPAGE="http://www.glassechidna.com.au/products/heimdall/"

EGIT_REPO_URI="git://github.com/Benjamin-Dobell/Heimdall.git
               https://github.com/Benjamin-Dobell/Heimdall.git"
EGIT_TREE="master"
EGIT_PROJECT="Heimdall"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="qt4"

RDEPEND="qt4? ( x11-libs/qt-core x11-libs/qt-gui )
         virtual/libusb:1"

DEPEND="${RDEPEND}
        dev-util/pkgconfig
        sys-libs/zlib"

src_prepare() {
    rm -r libusb-1.0 || die "Can't delete libusb sources"
    edos2unix "${S}"/${PN}/Makefile.am

    if use qt4; then
        edos2unix "${S}"/${PN}-frontend/${PN}-frontend.pro
    	sed -e 's:/usr/local:/usr:g' -i "${S}"/${PN}-frontend/${PN}-frontend.pro || die
    fi

#    sed 's:SYSFS:ATTRS:g' -i "${S}"/${PN}/60-${PN}-galaxy-s.rules || die
    sed -e '/sudo service udev restart/d' "${S}"/heimdall/Makefile.am -i

    cd "${S}/${PN}"
    eautoreconf
}

src_configure() {
    einfo
    einfo "Configuring libpit..."
    einfo
    cd "${S}"/libpit
    econf || die "econf failed"

    einfo
    einfo "Configuring ${PN}..."
    einfo
    cd "${S}"/${PN}
    econf || die "econf failed"

    if use qt4; then
        einfo
        einfo "Configuring ${PN}-frontend..."
        einfo
        cd "${S}"/${PN}-frontend
        eqmake4 heimdall-frontend.pro OUTPUTDIR="${D}/usr/bin/" || die "eqmake failed"
    fi
}

src_compile() {
    einfo
    einfo "Building libpit..."
    einfo
    cd "${S}"/libpit
    emake || die "compilation libpit failed"

    einfo
    einfo "Building ${PN}..."
    einfo
    cd "${S}"/${PN}
    emake || die "compilation ${PV} failed"

    if use qt4; then
        einfo
        einfo "Building ${PN}-frontend..."
        einfo
        cd "${S}"/${PN}-frontend
        emake OUTPUTDIR="${D}" || die "compilation ${PN}-frontend failed"
    fi
}

src_install() {
    einfo
    einfo "Installing libpit..."
    einfo
    cd "${S}"/libpit
    emake DESTDIR="${D}" install || die "installing ibpit failed"

    einfo
    einfo "Installing ${PN}..."
    einfo
    cd "${S}"/${PN}
    emake DESTDIR="${D}" install || die "installing ${PN} failed"

    if use qt4; then
        einfo
        einfo "Installing ${PN}-frontend..."
        einfo
        cd "${S}"/${PN}-frontend
        emake OUTPUTDIR="${D}" install || die "installing ${PN}-frontend failed"

		make_desktop_entry "heimdall-frontend" "Heimdall" ${PN} "Mobilephone;Utility;Qt"
    fi

    cd "${S}"
    dodoc Linux/README
}

pkg_postinst() {
    udevadm control --reload-rules && udevadm trigger --subsystem-match=usb
}

