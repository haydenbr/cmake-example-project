get_property(enabled_languages GLOBAL PROPERTY ENABLED_LANGUAGES)

message("enabled_languages: ${enabled_languages}")

# Use this function to promote an input argument that represents a list
# such that two layers of dereferencing aren't needed.
# This enables supporting both string and variable inputs with a function arg.
macro(check_and_double_deref input)
	if(NOT "${${${input}}}" STREQUAL "")
		set(${input} ${${${input}}})
	endif()
endmacro()

function(make_safe_varname input_string output_var)
	string(REPLACE - _ return_value ${input_string})
	set(${output_var} ${return_value} PARENT_SCOPE)
endfunction()

##################
# Compiler Flags #
##################

function(apply_supported_compiler_flags lang target scope flag_list)
	include(Check${lang}CompilerFlag)
	#[[
		${flag_list} this gives us the value of flag_list, which is the name of the variable provided as input
		${${flag_list}} this gives us the value of the variable provided
	]]
	check_and_double_deref(flag_list)
	
	foreach(flag ${flag_list})
		make_safe_varname(${flag} flag_var)
		cmake_language(CALL check_${lang}_compiler_flag ${flag} ${flag_var})

		if(${flag_var})
			target_compile_options(${target} ${scope} ${flag})
		endif()
	endforeach()
endfunction()

function(apply_supported_c_compiler_flags target scope flag_list)
	apply_supported_compiler_flags("C" ${target} ${scope} ${flag_list})
endfunction()

function(apply_supported_cxx_compiler_flags target scope flag_list)
	apply_supported_compiler_flags("CXX" ${target} ${scope} ${flag_list})
endfunction()

##################
# Linker Flags #
##################

function(apply_supported_linker_flags lang target scope flag_list)
	include(CheckLinkerFlag)
	check_and_double_deref(flag_list)
	
	foreach(flag ${flag_list})
		make_safe_varname(${flag} flag_var)
		check_linker_flag(${lang} {flag} ${flag_var})

		if(${flag_var})
			target_link_options(${target} ${scope} ${flag})
		endif()
	endforeach()
endfunction()

function(apply_supported_c_linker_flags target scope flag_list)
	apply_supported_linker_flags("C" ${target} ${scope} ${flag_list})
endfunction()

function(apply_supported_cxx_linker_flags target scope flag_list)
	apply_supported_linker_flags("CXX" ${target} ${scope} ${flag_list})
endfunction()