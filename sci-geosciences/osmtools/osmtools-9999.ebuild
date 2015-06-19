# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils subversion

ESVN_REPO_URI="http://svn.openstreetmap.org/applications/utils/revert"
DESCRIPTION="The osmtools scripts allows an Open Street Map (OSM) user a rollback of changesets"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Revert_scripts"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/libwww-perl
		 dev-lang/perl"

S="${WORKDIR}"

src_install() {
	# Install the perl modules
	insinto /usr/local/lib/site_perl
	doins *.pm
	# Install the perl scripts
	insinto /opt/${PN}	
	insopts -m755
	doins *.pl
	
	# Symlink the perl scripts
	dosym /opt/${PN}/changeset.pl /usr/bin/osm-changeset
	dosym /opt/${PN}/delete.pl /usr/bin/osm-delete
	dosym /opt/${PN}/revert.pl /usr/bin/osm-revert
	dosym /opt/${PN}/undelete.pl /usr/bin/osm-undelete
	dosym /opt/${PN}/undo.pl /usr/bin/osm-undo

	dodoc README
	dodoc ${FILESDIR}/dot-osmtoolsrc
}

pkg_postinst() {
	elog "Make sure to the your OSM username and password via ~/.osmtoolsrc"
	elog "A sample .osmtoolsrc can be found in /usr/share/doc/${PF}"
}