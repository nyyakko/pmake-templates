cmake_minimum_required(VERSION 3.5)
project(!PROJECT! LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})

include(static_analyzers)

option(ENABLE_CLANGTIDY "" TRUE)
option(ENABLE_CPPCHECK "" TRUE)

# set(!PROJECT!_LinkerOptions ${!PROJECT!_LinkerOptions}
#   . . .
# )

set(!PROJECT!_CompilerOptions ${!PROJECT!_CompilerOptions}
    -Werror
    -Wall
    -Wextra
    -Wshadow
    -Wcast-align
    -Wunused
    -Wpedantic
    -Wconversion
    -Wsign-conversion
    -Wnull-dereference
    -Wdouble-promotion
    -Wimplicit-fallthrough
)

# find_package(package CONFIG REQUIRED)
# . . .
#
# set(!PROJECT!_ExternalLibraries)

add_subdirectory(!PROJECT!)
