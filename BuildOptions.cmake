set(default_build_type "RelWithDebInfo")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
	message(STATUS "Setting built type to '${default_build_type}' as no value was specified")
	set(
		CMAKE_BUILD_TYPE
		"${default_build_type}"
		CACHE
		STRING "Choose the type of build"
		FORCE
	)

	set_property(
		CACHE CMAKE_BUILD_TYPE
		PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo"
	)
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
	message(STATUS "Setting 'build shared libraries' to '${default_shared_libs}' as no value was specified")
	set(
		BUILD_SHARED_LIBS
		"${default_build_shared_libs}" CACHE
		BOOL "Compile shared libraries by default instead of static libraries."
		FORCE
	)
endif()

set(default_compile_commands ON)
if("${CMAKE_EXPORT_COMPILE_COMMANDS}" STREQUAL "")
	message(STATUS "Setting 'export compile commands' tp '${default_compile_commands}' as no value was specified")
	set(
		CMAKE_EXPORT_COMPILE_COMMANDS
		${default_compile_commands}
		CACHE
		BOOL "Export compile_commands.json file"
		FORCE
	)
endif()

option(
	HIDE_UNIMPLEMENTED_C_APIS
	"Make unimplemented libc functions invisible to the compiler."
	OFF
)

option(
	ENABLE_GNU_EXTENSIONS
	"enables the GNU extensions to the standard libc functions."
	OFF
)

option(
	DISABLE_BUILTINS
	"add an -fno-builtin compilation flag to the library"
	ON
)

option(
	DISABLE_STACK_PROTECTION
	"add an -fno-stack-protector compilation flag to the libc target and its dependencies"
	ON
)

option(
	NOSTDINC_FOR_DEPENDENTS
	"adds -nostdinc flag for dependants"
	OFF
)

option(
	LIBC_BUILD_TESTING
	"enable unit test builds when this project is used as a dependency in another project"
	OFF
)