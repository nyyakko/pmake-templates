cmake_minimum_required(VERSION 3.5)
project(!PROJECT! LANGUAGES !LANGUAGE!)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
set(EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/cmake")
set(CMAKE_!LANGUAGE!_VERSION !STANDARD!)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set(CMAKE_TOOLCHAIN_FILE $ENV{CMAKE_TOOLCHAIN_FILE})

set(!PROJECT!_REQUIRES_VCPKG FALSE)

if (NOT ${CMAKE_TOOLCHAIN_FILE} STREQUAL "")
    message(STATUS "[${PROJECT_NAME}] vcpkg toolchain found.")
else()
    if (!PROJECT!_REQUIRES_VCPKG)
        message(FATAL_ERROR "[${PROJECT_NAME}] vcpkg toolchain was not found.")
    else()
        message(STATUS "[${PROJECT_NAME}] vcpkg toolchain not found. continuing without it.")
    endif()
endif()

# set(!PROJECT!_LinkerOptions ${!PROJECT!_LinkerOptions}
#   . . .
# )

set(!PROJECT!_CompilerOptions ${!PROJECT!_CompilerOptions}
    -Werror
    -Wall
    -Wextra
    -Wshadow
    -Wnon-virtual-dtor
    -Wold-style-cast
    -Wcast-align
    -Wunused
    -Woverloaded-virtual
    -Wpedantic
    -Wconversion
    -Wsign-conversion
    -Wnull-dereference
    -Wdouble-promotion
    -Wimplicit-fallthrough
)

include(static_analyzers)
include(GNUInstallDirs)

#
# find_package(package CONFIG REQUIRED)
# ...
#
# set(arser_ExternalLibraries package ...)
#

add_subdirectory(!PROJECT!)

if (NOT !PROJECT!_DISABLE_TESTS)
    message(STATUS "[${PROJECT_NAME}] Project will be building the test suit.")

    if (NOT ${CMAKE_HOST_SYSTEM_NAME} MATCHES "Windows")
        message(STATUS "[${PROJECT_NAME}] Running on ${CMAKE_HOST_SYSTEM_NAME}, sanitizers for tests are enabled.")
        set(!PROJECT!_TestsLinkerOptions ${!PROJECT!_TestsLinkerOptions} -fsanitize=undefined,leak,address)
    else()
        message(STATUS "[${PROJECT_NAME}] Running on ${CMAKE_HOST_SYSTEM_NAME}, sanitizers for tests are disabled.")
    endif()

    set(!PROJECT!_TestsCompilerOptions ${!PROJECT!_TestsCompilerOptions} ${!PROJECT!_CompilerOptions})

    include(GoogleTest)
    find_package(GTest CONFIG REQUIRED)

    enable_testing()
    add_subdirectory(tests)
else()
    message(STATUS "[${PROJECT_NAME}] Project will not be building the test suit.")
endif()
