
find_program(FASTRTPSGEN fastrtpsgen)

if (FASTRTPSGEN)
function(fastrtpsgen idl_files output_files)
  foreach(idl_file ${idl_files})

    get_filename_component(idl_name ${idl_file} NAME_WE)

    set(cpp_file ${idl_name}.cxx)
    set(header_file ${idl_name}.h)
    set(cpp_file_types ${idl_name}PubSubTypes.cxx)
    set(header_file_types ${idl_name}PubSubTypes.h)

    add_custom_command(OUTPUT ${PROJECT_BINARY_DIR}/generated/src/${cpp_file}
                              ${PROJECT_BINARY_DIR}/generated/src/${cpp_file_types}
                              ${PROJECT_BINARY_DIR}/generated/include/${header_file}
                              ${PROJECT_BINARY_DIR}/generated/include/${header_file_types}
        COMMAND mkdir -p ${PROJECT_BINARY_DIR}/generated/include
        COMMAND mkdir -p ${PROJECT_BINARY_DIR}/generated/src
        COMMAND ${FASTRTPSGEN} -d ${PROJECT_BINARY_DIR}/generated/include -replace ${idl_file}
        COMMAND mv ${PROJECT_BINARY_DIR}/generated/include/*.cxx ${PROJECT_BINARY_DIR}/generated/src/
        DEPENDS ${idl_file}
    )

    list(APPEND ${output_files} ${PROJECT_BINARY_DIR}/generated/src/${cpp_file}
                                ${PROJECT_BINARY_DIR}/generated/src/${cpp_file_types}
                                ${PROJECT_BINARY_DIR}/generated/include/${header_file}
                                ${PROJECT_BINARY_DIR}/generated/include/${header_file_types})

    set(${output_files} ${${output_files}} PARENT_SCOPE)
    include_directories(${PROJECT_BINARY_DIR}/generated/include)
  endforeach(idl_file)
endfunction(fastrtpsgen)
endif(FASTRTPSGEN)
