include(static_analyzers/clang_tidy)
include(static_analyzers/cppcheck)

function(enable_static_analyzers target ENABLED)

    find_program(CPPCHECK cppcheck)
    find_program(CLANGTIDY clang-tidy)

    if (ENABLED AND CPPCHECK AND CLANGTIDY)
        enable_clang_tidy(${target})
        enable_cppcheck()
    else()

endfunction()
