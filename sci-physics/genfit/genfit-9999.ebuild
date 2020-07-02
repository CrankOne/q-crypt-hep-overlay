# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 versionator

DESCRIPTION="Framework for track reconstruction for particle and nuclear physics."
HOMEPAGE="https://github.com/GenFit/GenFit"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GenFit/GenFit.git"
	KEYWORDS=""
else
	# .zip-snapshot can be recreated by visiting
	# http://sourceforge.net/p/${PN}/code/${COMMIT}/tarball?path=/tags/v$(replace_all_version_separators '-')
	TAG_VER=${PN}-code-1688-tags-v$(replace_all_version_separators '-')
	#SRC_URI="http://sourceforge.net/code-snapshots/svn/g/ge/genfit/code/${TAG_VER}.zip"
	SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${TAG_VER}.zip"
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
	S=${WORKDIR}/${TAG_VER}
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="rave test doc"

BDEPEND="dev-util/cmake"
RDEPEND="sci-physics/root
		dev-libs/boost
		dev-cpp/eigen
		rave? ( sci-physics/rave )
		test? ( dev-cpp/gtest )
		doc? ( app-doc/doxygen )"
DEPEND="${RDEPEND}"

src_configure() {
	if use rave ; then
		export RAVEPATH=/usr
	fi
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
