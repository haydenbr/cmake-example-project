cmake_minimum_required(VERSION 3.17)
project(
	EmbeddedArtistryLibc
	VERSION 1.0
	DESCRIPTION "A libc implementation for microcontroller-based embedded systems."
	LANGUAGES C
)
set_property(GLOBAL PROPERTY C_STANDARD 11)

include(cmake/CPM.cmake)

# printf
## install printf with CPM
CPMAddPackage(
	NAME printf
	GITHUB_REPOSITORY mpaland/printf
	VERSION 4.0.0
	DONWLOAD_ONLY
)

## defines a "library" that's used by other targets
add_library(printf INTERFACE)
# leaving this commented out for now to see what happens in the future
# target_sources(printf INTERFACE ${printf_SOURCE_DIR})
target_include_directories(printf SYSTEM INTERFACE ${printf_SOURCE_DIR})

# openlibm
## install openlibm with CPM
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

add_subdirectory(src)
