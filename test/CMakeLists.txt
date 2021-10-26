#######################
# printf unit tests #
#######################

add_executable(printf_tests)
target_sources(printf_tests PRIVATE ${printf_SOURCE_DIR}/test/test_suite.cpp)
target_include_directories(printf_tests PRIVATE ${printf_SOURCE_DIR})
set_target_properties(printf_tests PROPERTIES CXX_STANDARD 11)

add_test(
	NAME Printf.Test
	COMMAND printf_tests -s -r junit -o ${CMAKE_CURRENT_BINARY_DIR}/printf_tests.xml
)

#######################
# libc unit tests #
#######################

add_executable(libc_tests)

aux_source_directory(ctype libc_tests_target_sources)
aux_source_directory(stdlib libc_tests_target_sources)
aux_source_directory(string libc_tests_target_sources)
aux_source_directory(test libc_tests_target_sources)
target_sources(libc_tests
	PRIVATE main.c
	PRIVATE ${libc_tests_target_sources}
)

target_include_directories(
	libc_tests
	PRIVATE .
	PRIVATE test
)
target_include_directories(libc_tests SYSTEM PRIVATE ${CMOCKA_INCLUDE_DIR})

target_link_libraries(
	libc_tests
	PRIVATE c
	PRIVATE cmocka
)

add_test(
	NAME LibC.Tests
	COMMAND libc_tests
)

set_target_properties(
	libc_tests
	PROPERTIES
	ENVIRONMENT CMOCKA_XML_FILE=${CMAKE_CURRENT_BINARY_DIR}/%g.xml
)