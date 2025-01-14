include(CMakeFindDependencyMacro)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_dependency(Threads)
include("${CMAKE_CURRENT_LIST_DIR}/liblzmaTargets.cmake")

include(${CMAKE_ROOT}/Modules/SelectLibraryConfigurations.cmake)
find_path(LibLZMA_INCLUDE_DIR
    NAMES lzma.h
    PATH_SUFFIXES lzma
)
if(NOT LibLZMA_LIBRARY)
    find_library(LibLZMA_LIBRARY_RELEASE NAMES lzma LZMA LibLZMA liblzma PATHS ${_IMPORT_PREFIX}/lib/)
    find_library(LibLZMA_LIBRARY_DEBUG NAMES lzmad LZMAd LibLZMAd lzma LZMA LibLZMA liblzma PATHS ${_IMPORT_PREFIX}/debug/lib/)
    select_library_configurations(LibLZMA)
endif()
set(LibLZMA_INCLUDE_DIRS ${LibLZMA_INCLUDE_DIR} CACHE PATH "")
set(LibLZMA_LIBRARIES ${LibLZMA_LIBRARY} CACHE STRING "")
set(LZMA_INCLUDE_DIR ${LibLZMA_INCLUDE_DIR} CACHE PATH "")
set(LZMA_LIBRARY ${LibLZMA_LIBRARY} CACHE STRING "")
set(LZMA_INCLUDE_DIRS ${LibLZMA_INCLUDE_DIR} CACHE PATH "")
set(LZMA_LIBRARIES ${LibLZMA_LIBRARY} CACHE STRING "")
set(LIBLZMA_INCLUDE_DIRS ${LibLZMA_INCLUDE_DIR} CACHE PATH "")
set(LIBLZMA_LIBRARIES ${LibLZMA_LIBRARY} CACHE STRING "")
set(LIBLZMA_INCLUDE_DIR ${LibLZMA_INCLUDE_DIR} CACHE PATH "")
set(LIBLZMA_LIBRARY ${LibLZMA_LIBRARY} CACHE STRING "")

if(LIBLZMA_INCLUDE_DIR AND EXISTS "${LIBLZMA_INCLUDE_DIR}/lzma/version.h")
    file(STRINGS "${LIBLZMA_INCLUDE_DIR}/lzma/version.h" LIBLZMA_HEADER_CONTENTS REGEX "#define LZMA_VERSION_[A-Z]+ [0-9]+")

    string(REGEX REPLACE ".*#define LZMA_VERSION_MAJOR ([0-9]+).*" "\\1" LIBLZMA_VERSION_MAJOR "${LIBLZMA_HEADER_CONTENTS}")
    string(REGEX REPLACE ".*#define LZMA_VERSION_MINOR ([0-9]+).*" "\\1" LIBLZMA_VERSION_MINOR "${LIBLZMA_HEADER_CONTENTS}")
    string(REGEX REPLACE ".*#define LZMA_VERSION_PATCH ([0-9]+).*" "\\1" LIBLZMA_VERSION_PATCH "${LIBLZMA_HEADER_CONTENTS}")

    set(LIBLZMA_VERSION_STRING "${LIBLZMA_VERSION_MAJOR}.${LIBLZMA_VERSION_MINOR}.${LIBLZMA_VERSION_PATCH}")
    unset(LIBLZMA_HEADER_CONTENTS)
endif()

## We're using new code known now as XZ, even library still been called LZMA
## it can be found in http://tukaani.org/xz/
## Avoid using old codebase
#if (LIBLZMA_LIBRARY)
#   include(${CMAKE_ROOT}/Modules/CheckLibraryExists.cmake)
#   CHECK_LIBRARY_EXISTS(${LibLZMA_LIBRARY_RELEASE} lzma_auto_decoder "" LIBLZMA_HAS_AUTO_DECODER)
#   CHECK_LIBRARY_EXISTS(${LibLZMA_LIBRARY_RELEASE} lzma_easy_encoder "" LIBLZMA_HAS_EASY_ENCODER)
#   CHECK_LIBRARY_EXISTS(${LibLZMA_LIBRARY_RELEASE} lzma_lzma_preset "" LIBLZMA_HAS_LZMA_PRESET)
#endif ()

set(LibLZMA_FOUND TRUE CACHE BOOL "")
set(LZMA_FOUND TRUE CACHE BOOL "")
set(LIBLZMA_FOUND TRUE CACHE BOOL "")
