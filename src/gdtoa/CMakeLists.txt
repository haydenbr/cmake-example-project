add_library(gdtoa INTERFACE)

target_sources(gdtoa INTERFACE
	src/dmisc.c
	src/dtoa.c
	src/g__fmt.c
	src/g_ddfmt.c
	src/g_dfmt.c
	src/g_ffmt.c
	src/g_Qfmt.c
	src/g_xfmt.c
	src/g_xLfmt.c
	src/gdtoa.c
	src/gethex.c
	src/gmisc.c
	src/hd_init.c
	src/hexnan.c
	src/misc.c
	src/smisc.c
	src/strtod.c
	src/strtodg.c
	src/strtodI.c
	src/strtof.c
	src/strtoId.c
	src/strtoIdd.c
	src/strtoIf.c
	src/strtoIg.c
	src/strtoIQ.c
	src/strtoIx.c
	src/strtoIxL.c
	src/strtopd.c
	src/strtopdd.c
	src/strtopf.c
	src/strtopQ.c
	src/strtopx.c
	src/strtopxL.c
	src/strtord.c
	src/strtordd.c
	src/strtorf.c
	src/strtorQ.c
	src/strtorx.c
	src/strtorxL.c
	src/sum.c
	src/ulp.c
) # adding source files for the target

# these are required by the source files
# we add them as PUBLIC because library depdendents also need these
target_include_directories(gdtoa INTERFACE include)
# preprocessor definitions
target_compile_definitions(gdtoa INTERFACE
	NO_ERRNO
	IFNAN_CHECK
	GDTOA_NO_ASSERT
	NO_FENV_H
)