# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A framework for physics data reconstruction in abstract, versatile environment."
HOMEPAGE="https://rave.hepforge.org"
SRC_URI="https://rave.hepforge.org/downloads/?f=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test static java +flavortagging +kinematics +zvres -algorithm-ttf +algorithm-zvres +algorithm-mvf +algorithm-gsf +algorithm-tkvf development boost"

CDEPEND="
	sci-physics/clhep
	boost? ( dev-libs/boost )
	"
BDEPEND="
	${CDEPEND}
	java? ( virtual/jdk )
	"
RDEPEND="
	${CDEPEND}
	java? ( virtual/jre )
	"

src_configure() {
	econf \
		$(use_enable static) \
		$(use_enable test unittests) \
		$(use_enable flavortagging) \
		$(use_enable kinematics) \
		$(use_enable algorithm-zvres zvres) \
		$(use_enable algorithm-ttf ttf) \
		$(use_enable algorithm-mvf mvf) \
		$(use_enable algorithm-gsf gsf) \
		$(use_enable algorithm-tkvf tkvf) \
		$(use_enable development developers) \
		$(use_enable java)
}
