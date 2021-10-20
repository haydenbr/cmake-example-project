cmake_minimum_required(VERSION 3.17)
project(
	EmbeddedArtistryLibc
	VERSION 1.0
	DESCRIPTION "A libc implementation for microcontroller-based embedded systems."
	LANGUAGES C
)
set_property(GLOBAL PROPERTY C_STANDARD 11)
add_subdirectory(src)

include(cmake/CPM.cmake)

# install printf with CPM
CPMAddPackage(
	NAME printf
	GITHUB_REPOSITORY mpaland/printf
	VERSION 4.0.0
	DONWLOAD_ONLY
)

# defines a "library" that's used by other targets
add_library(printf INTERFACE)
target_sources(printf INTERFACE ${printf_SOURCE_DIR})
target_include_directories(printf SYSTEM INTERFACE ${printf_SOURCE_DIR})

# link the printf library with the c target
target_link_libraries(c PRIVATE printf)