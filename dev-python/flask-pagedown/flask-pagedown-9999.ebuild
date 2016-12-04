# Copyright 1999-2014 Q-Crypt Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit git-2 distutils-r1

DESCRIPTION="Implementation of StackOverflow's \"PageDown\" markdown editor for Flask and Flask-WTF."
HOMEPAGE="https://github.com/miguelgrinberg/flask-pagedown/"
LICENSE="MIT"
SLOT="0"
EGIT_REPO_URI="https://github.com/miguelgrinberg/flask-pagedown/"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=">=dev-python/flask-0.10[${PYTHON_USEDEP}]"
DEPEND="${DEPEND}"
