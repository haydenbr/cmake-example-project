include("/Users/haydenbraxton/Projects/cmake-example-project/cmake/CPM.cmake")
CPMAddPackage(NAME;openlibm;GIT_REPOSITORY;https://github.com/JuliaMath/openlibm.git;VERSION;0.7.0;DOWNLOAD_ONLY)
set(openlibm_FOUND TRUE)