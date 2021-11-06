#######################
# printf unit tests #
#######################

add_executable(printf_tests)

target_sources(printf_tests PRIVATE ${printf_SOURCE_DIR}/test/test_suite.cpp)
target_include_directories(printf_tests PRIVATE ${printf_SOURCE_DIR})
set_target_properties(printf_tests PROPERTIES CXX_STANDARD 11)

add_test(
	NAME Printf.Test
	COMMAND printf_tests -s -r junit -o ${CMAKE_CURRENT_BINARY_DIR}/testresults/printf_tests.xml
)

add_custom_target(test-printf printf_tests)

#######################
# libc unit tests #
#######################

add_executable(libc_tests)

list(APPEND libc_tests_compiler_flags
	"-Wno-stringop-overflow"
	"-Wno-unused-parameter"
	"-Wno-unknown-pragmas"
	"-Wno-nonnull-compare"
	"-Wno-nonnull"
	"-Wno-stringop-truncation"	
)
apply_supported_c_compiler_flags(
	libc_tests
	PRIVATE
	libc_tests_compiler_flags
)

aux_source_directory(ctype libc_tests_target_sources)
aux_source_directory(stdlib libc_tests_target_sources)
aux_source_directory(string libc_tests_target_sources)
aux_source_directory(test libc_tests_target_sources)
target_sources(libc_tests
	PRIVATE main.c
	PRIVATE ${libc_tests_target_sources}
)

list(
	REMOVE_ITEM
	CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES
	"${CMOCKA_INCLUDE_DIR}"
)
target_include_directories(libc_tests PRIVATE . test)
target_include_directories(libc_tests SYSTEM PRIVATE ${CMOCKA_INCLUDE_DIR})

target_link_libraries(
	libc_tests
	PRIVATE libc
	PRIVATE ${CMOCKA_LIBRARIES}
)

add_custom_target(test-clear-results
	COMMAND ${CMAKE_COMMAND} -E rm -f ${CMAKE_BINARY_DIR}/testresults/*.xml
	COMMENT "Removing XML files in the testresults/ dir"
)
add_test(
	NAME Libc.ClearResults
	COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target test-clear-results
)

add_test(
	NAME LibC.Tests
	COMMAND libc_tests
)
set_tests_properties(
	LibC.Tests
	PROPERTIES
		ENVIRONMENT CMOCKA_XML_FILE=${CMAKE_CURRENT_BINARY_DIR}/testresults/%g.xml
		DEPENDS Libc.ClearResults
)

add_custom_target(
	NAME test-libc
	COMMAND export CMOCKA_MESSAGE_OUTPUT=stdout
	COMMAND libc_tests
)