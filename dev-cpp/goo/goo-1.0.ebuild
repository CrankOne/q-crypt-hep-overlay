# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="The Goo Library"
HOMEPAGE="https://github.com/CrankOne/Goo"
EGIT_REPO_URI="https://github.com/CrankOne/Goo.git"
EGIT_BRANCH=master
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="allocators +color gds haskell ptree streams tensors +stacktrace +unit-tests
	  static-libs"

if [[ ${PV} != 9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
	EGIT_BRANCH=development
fi

RDEPEND=" gds? ( virtual/yacc )
		  haskell? ( dev-lang/ghc ) "
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DTYPES_128BIT_LENGTH=OFF
		-DSOURCE_POSITION_INFO=OFF
		-DEM_STACK_UNWINDING=$(usex stacktrace)
		-DANSI_ESCSEQ_PRINT=$(usex colors)
		-DENABLE_GDS=$(usex gds)
		-DENABLE_ALLOCATORS=$(usex allocators)
		-DENABLE_TENSORS=$(usex tensors)
		-DENABLE_DATASTREAMS=$(usex streams)
		-DENABLE_PTREE=$(usex ptree)
		-DHASKELL_MODULE=$(usex haskell)
		-DBUILD_STATIC_LIBRARIES=$(usex static-libs)
		-Dbuild_unit_tests=$(usex unit-test)
		-Dbuild_system_tests=$(usex unit-test)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
