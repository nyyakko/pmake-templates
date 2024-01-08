add_subdirectory(source)

add_executable(${PROJECT_NAME} "${!PROJECT!_SourceFiles}")

enable_static_analyzers(${PROJECT_NAME} ON)

target_include_directories(${PROJECT_NAME} 
    PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include" 
    PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include/!PROJECT!"
)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_!STANDARD!)

target_link_options(${PROJECT_NAME} PRIVATE ${!PROJECT!_LinkerOptions})
target_compile_options(${PROJECT_NAME} PRIVATE ${!PROJECT!_CompilerOptions})
target_link_libraries(${PROJECT_NAME} PRIVATE ${!PROJECT!_ExternalLibraries})
