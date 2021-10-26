add_library(gdtoa INTERFACE)

target_sources(gdtoa INTERFACE
	gdtoa/src/dmisc.c
	gdtoa/src/dtoa.c
	gdtoa/src/g__fmt.c
	gdtoa/src/g_ddfmt.c
	gdtoa/src/g_dfmt.c
	gdtoa/src/g_ffmt.c
	gdtoa/src/g_Qfmt.c
	gdtoa/src/g_xfmt.c
	gdtoa/src/g_xLfmt.c
	gdtoa/src/gdtoa.c
	gdtoa/src/gethex.c
	gdtoa/src/gmisc.c
	gdtoa/src/hd_init.c
	gdtoa/src/hexnan.c
	gdtoa/src/misc.c
	gdtoa/src/smisc.c
	gdtoa/src/strtod.c
	gdtoa/src/strtodg.c
	gdtoa/src/strtodI.c
	gdtoa/src/strtof.c
	gdtoa/src/strtoId.c
	gdtoa/src/strtoIdd.c
	gdtoa/src/strtoIf.c
	gdtoa/src/strtoIg.c
	gdtoa/src/strtoIQ.c
	gdtoa/src/strtoIx.c
	gdtoa/src/strtoIxL.c
	gdtoa/src/strtopd.c
	gdtoa/src/strtopdd.c
	gdtoa/src/strtopf.c
	gdtoa/src/strtopQ.c
	gdtoa/src/strtopx.c
	gdtoa/src/strtopxL.c
	gdtoa/src/strtord.c
	gdtoa/src/strtordd.c
	gdtoa/src/strtorf.c
	gdtoa/src/strtorQ.c
	gdtoa/src/strtorx.c
	gdtoa/src/strtorxL.c
	gdtoa/src/sum.c
	gdtoa/src/ulp.c
) # adding source files for the target

# these are required by the source files
# we add them as PUBLIC because library depdendents also need these
target_include_directories(gdtoa INTERFACE gdtoa/include)
# preprocessor definitions
target_compile_definitions(gdtoa INTERFACE
	NO_ERRNO
	IFNAN_CHECK
	GDTOA_NO_ASSERT
	NO_FENV_H
)

add_library(c STATIC)

# printf module
target_link_libraries(c PRIVATE printf openlibm)
## as private, we'll see warnings when building libc
## but not when linking against libc
target_include_directories(c
	PRIVATE
		${PROJECT_SOURCE_DIR}/include
		${PROJECT_SOURCE_DIR}/arch/x86_64/include
)
## this makes these available as deps
## but SYSTEM supresses warnings for users
## linking against libc
target_include_directories(
	c SYSTEM INTERFACE
		${PROJECT_SOURCE_DIR}/include
		${PROJECT_SOURCE_DIR}/arch/x86_64/include
		$<TARGET_PROPERTY:openlibm,INTERFACE_INCLUDE_DIRECTORIES>
)

# Assert Module
target_sources(c PRIVATE
	assert/assert.c
)

# CType Module
## doing this is nice and terse, but since this
## doesn't require adding a new source file
## to the list, there's no change to CMakeList.txt
## so building doesn't cause cmake to rerun
aux_source_directory(support ctype_target_sources)
target_sources(c PRIVATE ${ctype_target_sources})

# stdlib Module
target_sources(c PRIVATE
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
target_sources(c PRIVATE
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
target_sources(c PRIVATE
	locale/langinfo.c
)

# math Module
target_sources(c PRIVATE
	math/fabs.c
	math/fabsf.c
)

# stdio Module
target_sources(c PRIVATE
	stdio/asprintf.c
	stdio/putchar.c
	stdio/puts.c
	stdio/vasprintf.c
)

# stdio_native Module
target_sources(c PRIVATE
	stdio/putchar_native.c
)

# support Module
target_sources(c PRIVATE
	support/fls.c
	support/flsl.c
	support/flsll.c
)

# time Module
target_sources(c PRIVATE
	time/asctime.c
	time/asctime_r.c
)

# string Module
target_sources(c PRIVATE
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
target_include_directories(c PUBLIC ${PROJECT_SOURCE_DIR}/include)
# architecture-specific deps required by some of the modules
target_include_directories(c PUBLIC ${PROJECT_SOURCE_DIR}/arch/x86_64/include)
target_link_libraries(c PRIVATE gdtoa)