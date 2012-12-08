# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""
DESCRIPTION="GStreamer plugin for VDPAU support"

RDEPEND="x11-libs/libvdpau
	>=media-libs/gst-plugins-base-0.10.36"
DEPEND="${RDEPEND}"
