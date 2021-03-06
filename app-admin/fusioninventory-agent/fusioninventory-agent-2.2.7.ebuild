# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit perl-module

MY_PN="FusionInventory-Agent"
DESCRIPTION="Client appplication for powerful inventory and package management system."
HOMEPAGE="http://www.fusioninventory.org/"
SRC_URI="http://forge.fusioninventory.org/attachments/download/867/FusionInventory-Agent-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="sys-apps/dmidecode
        dev-perl/File-Which
        dev-perl/IO-Socket-SSL
        dev-perl/UNIVERSAL-require
        dev-perl/XML-TreePP
"
RDEPEND="${DEPEND}"

MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
myconf="SYSCONFDIR=/etc/fusioninventory"

src_install() { 
        emake install 
        dodir /usr/var/fusioninventory/ 
}

pkg_postinst() { 
        elog "To configure Fusioninventory-agent," 
        elog "edit the file /etc/fusioninventory/agent.cfg," 
        elog "read the following web page:" 
        elog "http://www.fusioninventory.org/documentation/agent/configuration/" 
}

