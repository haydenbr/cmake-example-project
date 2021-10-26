include("/Users/haydenbraxton/Projects/cmake-example-project/cmake/CPM.cmake")
CPMAddPackage(NAME;cmocka;GIT_REPOSITORY;https://git.cryptomilk.org/projects/cmocka.git/;VERSION;1.1.5;GIT_TAG;cmocka-1.1.5;OPTIONS;WITH_EXAMPLES OFF;CMAKE_BUILD_TYPE DEBUG)
set(cmocka_FOUND TRUE)