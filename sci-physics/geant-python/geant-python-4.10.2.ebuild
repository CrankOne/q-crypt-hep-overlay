# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 versionator multilib eutils cmake-utils

# http://geant4.cern.ch/support/source/geant4.10.02.p02.tar.gz
MY_PN="geant"
MY_PV="4.10.02"
#MY_PR="p02"

MYP="${MY_PN}${MY_PV}"

DESCRIPTION="Python bindings for Geant4"
HOMEPAGE="http://geant4.cern.ch/"
SRC_URI="http://geant4.cern.ch/support/source/${MYP}.tar.gz"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

LICENSE="geant4"
SLOT="0"
IUSE="examples"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/boost[${PYTHON_USEDEP}]
	dev-libs/xerces-c
	=sci-physics/geant-${MY_PV}*"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}/environments/g4py"

pkg_setup() {
	if use amd64; then
		ARG=linux64
	elif use x86; then
		ARG=linux
	else
		die "platform unknown"
	fi
}

src_prepare() {
	# Get rid of hardcoded internal CLHEP lib:
	sed -i -e 's/G4clhep//g' cmake/Modules/FindGeant4.cmake || die
	# Get rid of hardcoded libboost_python:
	find . -name CMakeLists.txt -type f -print0 | xargs -0 sed -i 's/boost_python/${Boost_LIBRARIES}/g'
	epatch "${FILESDIR}"/${PN}-4.10.2-boost_python_lib.patch
}

src_configure() {
	reconfigure_cmake() {
		local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX=$(python_get_sitedir)
			-DCMAKE_INSTALL_LIBDIR=.
		)
		cmake-utils_src_configure
	}

	python_foreach_impl run_in_build_dir reconfigure_cmake
}

src_compile() {
	cmake-utils_src_compile
	#python_foreach_impl run_in_build_dir emake CPPVERBOSE=1
}

src_test() {
	run_test() {
		emake -C tests
	}
	python_foreach_impl run_in_build_dir run_test
}

src_install() {
	cmake-utils_src_install
	#python_foreach_impl run_in_build_dir emake DESTDIR="${D}" install
	dodoc README.md History
	insinto /usr/share/doc/${PF}
	use examples && doins -r examples
}
