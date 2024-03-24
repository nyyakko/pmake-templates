cmake_minimum_required(VERSION 3.25)

project(!PROJECT! LANGUAGES C)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
set(EXPORT_DIR "${CMAKE_SOURCE_DIR}/build/cmake")

include(static_analyzers)
include(enable_tests)
include(GNUInstallDirs)

option(ENABLE_CLANGTIDY "" TRUE)
option(ENABLE_CPPCHECK "" TRUE)
option(ENABLE_TESTING "" TRUE)

if (ENABLE_TESTING)
    enable_tests()
endif()

# set(!PROJECT!_CompilerOptions ${!PROJECT!_CompilerOptions})
# set(!PROJECT!_LinkerOptions ${!PROJECT!_LinkerOptions})

# find_package(package1 CONFIG REQUIRED)
# find_package(package2 CONFIG REQUIRED)
# ...
#
# set(!PROJECT!_ExternalLibraries package1 package2 ...)

add_subdirectory(!PROJECT!)
