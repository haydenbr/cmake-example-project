add_library(gdtoa STATIC) # This is a target we want to build!

set(gdtoa_target_sources
	dmisc.c
	dtoa.c
	g__fmt.c
	g_ddfmt.c
	g_dfmt.c
	g_ffmt.c
	g_Qfmt.c
	g_xfmt.c
	g_xLfmt.c
	gdtoa.c
	gethex.c
	gmisc.c
	hd_init.c
	hexnan.c
	misc.c
	smisc.c
	strtod.c
	strtodg.c
	strtodI.c
	strtof.c
	strtoId.c
	strtoIdd.c
	strtoIf.c
	strtoIg.c
	strtoIQ.c
	strtoIx.c
	strtoIxL.c
	strtopd.c
	strtopdd.c
	strtopf.c
	strtopQ.c
	strtopx.c
	strtopxL.c
	strtord.c
	strtordd.c
	strtorf.c
	strtorQ.c
	strtorx.c
	strtorxL.c
	sum.c
	ulp.c
)
list(TRANSFORM gdtoa_target_sources PREPEND "gdtoa/src/")

target_sources(gdtoa PRIVATE ${gdtoa_target_sources}) # adding source files for the target

# these are required by the source files
# we add them as PUBLIC because library depdendents also need these
target_include_directories(gdtoa PUBLIC gdtoa/include)
# preprocessor definitions
target_compile_definitions(gdtoa PRIVATE
	NO_ERRNO
	IFNAN_CHECK
	GDTOA_NO_ASSERT
	NO_FENV_H
)

add_library(c STATIC)

# Assert Module
# target_sources(c PRIVATE
# 	assert/assert.c
# )

# CType Module
target_sources(c PRIVATE
	ctype/isalnum.c
	ctype/isalpha.c
	ctype/isascii.c
	ctype/isblank.c
	ctype/iscntrl.c
	ctype/isdigit.c
	ctype/isgraph.c
	ctype/islower.c
	ctype/isprint.c
	ctype/ispunct.c
	ctype/isspace.c
	ctype/isupper.c
	ctype/isxdigit.c
	ctype/toascii.c
	ctype/tolower.c
	ctype/toupper.c
)

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
# target_sources(c PRIVATE
# 	math/fabs.c
# 	math/fabsf.c
# )

# stdio Module
# target_sources(c PRIVATE
# 	stdio/asprintf.c
# 	stdio/putchar.c
# 	stdio/puts.c
# 	stdio/vasprintf.c
# )

# stdio_native Module
# target_sources(c PRIVATE
# 	stdio/putchar_native.c
# )

# support Module
target_sources(c PRIVATE
	support/fls.c
	support/flsl.c
	support/flsll.c
)

# time Module
# target_sources(c PRIVATE
# 	time/asctime.c
# 	time/asctime_r.c
# )

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
