set(vs_props)
if (superbuild_is_64bit)
  list(APPEND vs_props
    "/p:ZLIB_INC_DIR=${install_location}/include"
    "/p:ZLIB_LIB_DIR_X64=${install_location}/lib"
    "/p:HDF5_INC_DIR_X64=${install_location}/include"
    "/p:HDF5_LIB_DIR_X64=${install_location}/lib")
  set(silo_platform "x64")
else ()
  list(APPEND vs_props
    "/p:ZLIB_INC_DIR=${install_location}/include"
    "/p:ZLIB_LIB_DIR=${install_location}/lib"
    "/p:HDF5_INC_DIR=${install_location}/include"
    "/p:HDF5_LIB_DIR=${install_location}/lib")
  set(silo_platform "Win32")
endif ()

execute_process(
  COMMAND ${MSBUILD_PATH}
          "${source_location}/SiloWindows/MSVC2012/Silo.sln"
          /p:Configuration=Release
          "/p:Platform=${silo_platform}"
          "/p:PlatformToolset=${vs_toolset}"
          "/p:VisualStudioVersion=${vs_version}"
          /target:Silo
          ${vs_props}
  WORKING_DIRECTORY "${source_location}"
  RESULT_VARIABLE res_build)

if (res_build)
  message(FATAL_ERROR "Error building Silo!")
endif ()
