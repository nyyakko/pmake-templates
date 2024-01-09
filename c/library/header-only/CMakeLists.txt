cmake_minimum_required(VERSION 3.5)
project(!PROJECT! LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
set(EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/cmake")

include(static_analyzers)
include(GNUInstallDirs)

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
# set(arser_ExternalLibraries package ...)

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
