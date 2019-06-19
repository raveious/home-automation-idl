
find_program(FASTRTPSGEN fastrtpsgen)
find_program(MICROXRCEDDSGEN microxrceddsgen)

if (FASTRTPSGEN)
function(fastrtpsgen idl_files output_files)
  foreach(idl_file ${idl_files})

    get_filename_component(idl_name ${idl_file} NAME_WE)

    set(cpp_file ${idl_name}.cxx)
    set(header_file ${idl_name}.h)
    set(cpp_file_types ${idl_name}PubSubTypes.cxx)
    set(header_file_types ${idl_name}PubSubTypes.h)

    add_custom_command(OUTPUT ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/${cpp_file}
                              ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/${cpp_file_types}
                              ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/${header_file}
                              ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/${header_file_types}
        COMMAND mkdir -p ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src
        COMMAND ${FASTRTPSGEN} -d ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include -replace ${idl_file}
        COMMAND mv ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/*.cxx ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/
        COMMENT "Generating source from ${idl_file}"
        DEPENDS ${idl_file}
    )

    list(APPEND ${output_files} ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/${cpp_file}
                                ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/${cpp_file_types}
                                ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/${header_file}
                                ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/${header_file_types})

    set(${output_files} ${${output_files}} PARENT_SCOPE)
    include_directories(${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include)
  endforeach(idl_file)
endfunction(fastrtpsgen)
endif(FASTRTPSGEN)

if (MICROXRCEDDSGEN)
function(microxrceddsgen idl_files output_files)
  foreach(idl_file ${idl_files})

    get_filename_component(idl_name ${idl_file} NAME_WE)

    set(c_file ${idl_name}.c)
    set(header_file ${idl_name}.h)

    add_custom_command(OUTPUT ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/${c_file}
                              ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/${header_file}
        COMMAND mkdir -p ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src
        COMMAND ${MICROXRCEDDSGEN} -d ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include -replace ${idl_file}
        COMMAND mv ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/*.c ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/
        COMMENT "Generating source from ${idl_file}"
        DEPENDS ${idl_file}
    )

    list(APPEND ${output_files} ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/src/${c_file}
                                ${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include/${header_file})

    set(${output_files} ${${output_files}} PARENT_SCOPE)
    include_directories(${PROJECT_BINARY_DIR}/generated/${PROJECT_NAME}/include)
  endforeach(idl_file)
endfunction(microxrceddsgen)
endif(MICROXRCEDDSGEN)

