cmake_minimum_required(VERSION 3.17)
project(
	EmbeddedArtistryLibc
	VERSION 1.0
	DESCRIPTION "A libc implementation for microcontroller-based embedded systems."
	LANGUAGES C CXX
)
set_property(GLOBAL PROPERTY C_STANDARD 11)

include(cmake/CPM.cmake)
include(ExternalProject)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
	include(CTest)
endif()

set(default_position_independent_code ON)
if(NOT DEFINED CMAKE_POSITION_INDEPENDENT_CODE)
	message(STATUS "Setting PIC for all targets to '${default_position_independent_code}' as no value was specified")
	set(
		CMAKE_POSITION_INDEPENDENT_CODE
		"${default_position_independent_code}" CACHE
		BOOL "Compile all targets with -fPIC"
		FORCE
	)
endif()

set(default_build_shared_libs OFF)
if(NOT DEFINED BUILD_SHARED_LIBS)
	message(STATUS "Setting 'build shared libraries' to '${default_shared_libs}' as no value was specified.")
	set(
		BUILD_SHARED_LIBS
		"${default_build_shared_libs}" CACHE
		BOOL "Compile shared libraries by default instead of static libraries."
		FORCE
	)
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#####################
# Printf Dependency #
#####################

CPMAddPackage(
	NAME printf
	GITHUB_REPOSITORY mpaland/printf
	VERSION 4.0.0
	DONWLOAD_ONLY
)

## defines a "library" that's used by other targets
add_library(printf INTERFACE)
target_sources(printf INTERFACE ${printf_SOURCE_DIR})
target_include_directories(printf SYSTEM INTERFACE ${printf_SOURCE_DIR})

#######################
# Openlibm Dependency #
#######################

CPMAddPackage(
	NAME openlibm
	GIT_REPOSITORY https://github.com/JuliaMath/openlibm.git
	VERSION 0.7.0
	DOWNLOAD_ONLY
)

add_library(openlibm INTERFACE)
# we don't have to add sources because right now
# our libc is only using header files from openlibm
target_include_directories(openlibm SYSTEM INTERFACE
	${openlibm_SOURCE_DIR}/src
	${openlibm_SOURCE_DIR}/include
)

#####################
# CMocka Dependency #
#####################

CPMAddPackage(
	NAME cmocka
	GIT_REPOSITORY https://git.cryptomilk.org/projects/cmocka.git/
	VERSION 1.1.5
	GIT_TAG cmocka-1.1.5
	DOWNLOAD_ONLY YES
)

# Convenience variable to shorten our code below
set(CMOCKA_STATIC_FILENAME
	${CMAKE_STATIC_LIBRARY_PREFIX}cmocka-static${CMAKE_STATIC_LIBRARY_SUFFIX}
)

# We would normally use CPMAddPackage, but CMocka's build presents problems.
# So we include it as an external project, which allows us to build the lib
# separately and then link it in.
ExternalProject_Add(project_cmocka
	SOURCE_DIR ${cmocka_SOURCE_DIR}
	PREFIX ${CMAKE_CURRENT_BINARY_DIR}/cmocka
	BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/cmocka
	CMAKE_ARGS
		-DBUILD_STATIC_LIB=ON
		-DWITH_STATIC_LIB=ON # Without this, Cmocka will not install the static lib
		-DWITH_EXAMPLES=OFF
		-DCMAKE_BUILD_TYPE=Debug
		-DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/cmocka
	# This is needed with Ninja generators to prevent it from failing due to
	# the library being missing before the build has been run
	BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/cmocka/lib/${CMOCKA_STATIC_FILENAME}
)

# We need to get the CMocka installation directory to know where our
# built libraries can be found
ExternalProject_Get_Property(project_cmocka BINARY_DIR)

# Now we define an IMPORTED library target and tell CMake where the library
# files can be found. To ensure the build flows in the proper order,
# we'll add a dependency on the ExternalProject target above, which will
# ensure the library is built before we try to link it
add_library(cmocka-static STATIC IMPORTED)
set_target_properties(cmocka-static PROPERTIES
	IMPORTED_LOCATION ${BINARY_DIR}/lib/${CMOCKA_STATIC_FILENAME}
)
add_dependencies(cmocka-static project_cmocka)

# Maintain build compatibility between find_package and CMakeLists.txt variants.
set(CMOCKA_LIBRARIES cmocka-static)
set(CMOCKA_INCLUDE_DIR ${BINARY_DIR}/include)

#######################
# Process Source Tree #
#######################

add_subdirectory(src)

if(BUILD_TESTING) # BUILD_TESTING comes from CTest module
	add_subdirectory(test)
endif()