# Q-Crypt/HEP Gentoo Overlay

This overlay contains ebuilds devoted mostly to High-Energy Physics (HEP). There
also some customization of packages outdated in oficial Gentoo overlay.

All these ebuilds are maintained under the auspices of HEP Laboratory and can be
re-distributed under GPL-2 license.

# Ebuilds and Rationale

Below is the list of ebuilds being introduced by this overlay and their
motivation:

1. (*deprecated*) `app-admin/fusioninventory-agent-2.2.7` -- was not found in the
official portages (at 2016).
2. (*deprecated*) `app-misc/worker-3.8.2` -- version bump (2016)
3. (*deprecated*) `dev-cpp/goo` -- our internal (Q-Crypt's) C++ toolbox library
4. (*deprecated*) `dev-libs/libxml2-2.9.4-r1` -- version bump (2017)
5. (*deprecated*) `dev-python/pagedown-9999` -- not in the official tree
6. (*deprecated*) `dev-python/geant4py` -- version bump (2017)
7. (*deprecated*) `sci-physics/geant-python` -- same as for `dev-python/geant4py`
8. `sci-physics/geant-4.10.6_p2` -- the python bindings (`g4py`) had
became a part of Geant4 source distribution since a while, but no support was
found in the official Gentoo ebuilds.
9. `sci-physics/genfit` -- a versatile, well-written track reconstruction
framework for particle physics, not in the official tree
10. `sci-physics/rave` -- required by genfit, not in the official tree
11. (*deprecated*) `sci-physics/root` -- version bump (2017)

Some deprecated packages are kept alive here to provide backward compatibility
for existing software. Relying on them in newly written software is discouraged
as we would remove the deprecated ones after a while (typically a year or two).

## Geant4 Changelog (ebuild)

### At 10.08.2020 - establishing compatibility with Python

Ebuild and metadata changes:

- The `python` use flag and `PYTHON_SINGLE_TARGET` expand var were introduced
into ebuild
- The patch (`*-boost-python-bindings`) was introduced for the compatibility
with the recent versions of `boost`

Changes in CMake files introduced by patches:

1. The docs of recent boost library advices changed form of `find_package()`
function that is related to boost-python. At `environments/g4py/CMakeLists.txt:11`
the following signature must be applied in order to provide the compat:

    find_package(Boost COMPONENTS python37 REQUIRED)

Unless the fatal error of missing boost's component "python" will appear
(component containing version suffix, i.e. called "python37" won't cause the
error). Note that certain python version is set here. Also in
`environments/g4py/G4PythonHelpers.cmake:42` one have to change `Boost::python`
to `Boost::python37` or whatever. To use the interpreter being in use at CMake
we shall set the requirement to `${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}`

*TODO*: currently CMake decides which version of the Python interpreter must be
used and this value is further used by `find_package()` call. Although, current
ebuild does not prevent a malformed configuration when boost was not built
against version of ointerpreter sepcified by `PYTHON_SINGLE_TARGET`. One has to
introduce this assertion at some point.

