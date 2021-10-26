cmake_minimum_required(VERSION 3.17)
project(
	EmbeddedArtistryLibc
	VERSION 1.0
	DESCRIPTION "A libc implementation for microcontroller-based embedded systems."
	LANGUAGES C CXX
)
set_property(GLOBAL PROPERTY C_STANDARD 11)

include(cmake/CPM.cmake)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
	include(CTest)
endif()

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
	OPTIONS
		"WITH_EXAMPLES OFF"
		"CMAKE_BUILD_TYPE DEBUG"
)
set(CMOCKA_LIBRARIES cmocka)

#######################
# Process Source Tree #
#######################

add_subdirectory(src)

if(BUILD_TESTING) # BUILD_TESTING comes from CTest module
	add_subdirectory(test)
endif()