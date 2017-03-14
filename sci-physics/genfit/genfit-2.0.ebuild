# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Framework for track reconstruction for particle and nuclear physics."
HOMEPAGE="https://github.com/CrankOne/GenFit"
EGIT_REPO_URI="https://github.com/CrankOne/GenFit.git"
EGIT_BRANCH=cmakeconf
SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sci-physics/root
		dev-libs/boost"
DEPEND="${RDEPEND}"

src_configure() {
	#local mycmakeargs=()  # TODO
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
