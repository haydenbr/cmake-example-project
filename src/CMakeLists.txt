add_library(libc)

list(APPEND libc_compiler_flags
	"-Wno-nonnull-compare"
	"-Wno-unknown-pragmas"
)
apply_supported_c_compiler_flags(
	libc
	PRIVATE
	libc_compiler_flags
)

# printf module
target_link_libraries(libc PRIVATE printf openlibm)
## as private, we'll see warnings when building libc
## but not when linking against libc
target_include_directories(libc
	PRIVATE
		${PROJECT_SOURCE_DIR}/include
		${PROJECT_SOURCE_DIR}/arch/x86_64/include
)
## this makes these available as deps
## but SYSTEM supresses warnings for users
## linking against libc
target_include_directories(
	libc SYSTEM INTERFACE
		${PROJECT_SOURCE_DIR}/include
		${PROJECT_SOURCE_DIR}/arch/x86_64/include
		$<TARGET_PROPERTY:openlibm,INTERFACE_INCLUDE_DIRECTORIES>
)

# Assert Module
target_sources(libc PRIVATE
	assert/assert.c
)

# CType Module
## doing this is nice and terse, but since this
## doesn't require adding a new source file
## to the list, there's no change to CMakeList.txt
## so building doesn't cause cmake to rerun
aux_source_directory(support ctype_target_sources)
target_sources(libc PRIVATE ${ctype_target_sources})

# stdlib Module
target_sources(libc PRIVATE
	stdlib/abs.c
	stdlib/atof.c
	stdlib/atoi.c
	stdlib/atol.c
	stdlib/atoll.c
	stdlib/bsearch.c
	stdlib/calloc.c
	stdlib/div.c
	stdlib/heapsort_r.c
	stdlib/heapsort.c
	stdlib/imaxabs.c
	stdlib/imaxdiv.c
	stdlib/labs.c
	stdlib/ldiv.c
	stdlib/llabs.c
	stdlib/lldiv.c
	stdlib/qsort_r.c
	stdlib/qsort.c
	stdlib/rand.c
	stdlib/realloc.c
	stdlib/strtol.c
	stdlib/strtold.c
	stdlib/strtoul.c
	stdlib/strtoll.c
	stdlib/strtoull.c
)

# wchar Module
target_sources(libc PRIVATE
	wchar/iswalnum.c
	wchar/iswalpha.c
	wchar/iswblank.c
	wchar/iswcntrl.c
	wchar/iswalnum.c
	wchar/iswalpha.c
	wchar/iswblank.c
	wchar/iswcntrl.c
	wchar/iswctype.c
	wchar/iswdigit.c
	wchar/iswgraph.c
	wchar/iswlower.c
	wchar/iswprint.c
	wchar/iswpunct.c
	wchar/iswspace.c
	wchar/iswupper.c
	wchar/iswxdigit.c
	wchar/towccase.c
	wchar/towctrans.c
	wchar/towlower.c
	wchar/towupper.c
	wchar/wcswidth.c
	wchar/wctrans.c
	wchar/wctype.c
	wchar/wcwidth.c
)

# locale Module
target_sources(libc PRIVATE
	locale/langinfo.c
)

# math Module
target_sources(libc PRIVATE
	math/fabs.c
	math/fabsf.c
)

# stdio Module
target_sources(libc PRIVATE
	stdio/asprintf.c
	stdio/putchar.c
	stdio/puts.c
	stdio/vasprintf.c
)

# stdio_native Module
target_sources(libc PRIVATE
	stdio/putchar_native.c
)

# support Module
target_sources(libc PRIVATE
	support/fls.c
	support/flsl.c
	support/flsll.c
)

# time Module
target_sources(libc PRIVATE
	time/asctime.c
	time/asctime_r.c
)

# string Module
target_sources(libc PRIVATE
	string/memcmp.c
	string/memcpy.c
	string/memmem.c
	string/memmove.c
	string/memchr.c
	string/memrchr.c
	string/memset.c
	string/strcat.c
	string/strchr.c
	string/strchrnul.c
	string/strcmp.c
	string/strcoll.c
	string/strcpy.c
	string/strcspn.c
	string/strdup.c
	string/strerror.c
	string/strerror_r.c
	string/strlen.c
	string/strncat.c
	string/strncmp.c
	string/strncpy.c
	string/strndup.c
	string/strnlen.c
	string/strnstr.c
	string/strpbrk.c
	string/strrchr.c
	string/strspn.c
	string/strstr.c
	string/strtok.c
	string/strxfrm.c
)

# without these header files, the compiler thinks we're redefining built-in functions
target_include_directories(libc PUBLIC ${PROJECT_SOURCE_DIR}/include)
# architecture-specifilibc deps required by some of the modules
target_include_directories(libc PUBLIC ${PROJECT_SOURCE_DIR}/arch/x86_64/include)

add_subdirectory(gdtoa)
target_link_libraries(libc PRIVATE gdtoa)