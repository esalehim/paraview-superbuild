set(ospray_isa_default "ALL")
if (DEFINED OSPRAY_BUILD_ISA)
  message(WARNING "The OSPRAY_BUILD_ISA setting is deprecated in favor of ospray_BUILD_ISA.")
  set(ospray_isa_default "${OSPRAY_BUILD_ISA}")
endif ()

set(ospray_BUILD_ISA "${ospray_isa_default}"
  CACHE STRING "Target ISA for OSPRay (SSE, AVX, AVX2, AVX512KNL, AVX512SKX, or ALL).")
mark_as_advanced(ospray_BUILD_ISA)
set_property(CACHE ospray_BUILD_ISA PROPERTY STRINGS SSE AVX AVX2 AVX512KNL AVX512SKX ALL)

set (ospray_depends ispc tbb cxx11 embree ospraymaterials openimagedenoise)

superbuild_add_project(ospray
  DEPENDS ${ospray_depends}
  CMAKE_ARGS
    -DTBB_ROOT:PATH=<INSTALL_DIR>
    -DOSPRAY_ISPC_DIRECTORY:PATH=<INSTALL_DIR>/bin
    -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
    -DOSPRAY_BUILD_ISA:STRING=${ospray_BUILD_ISA}
    -DOSPRAY_APPS_BENCHMARK:BOOL=OFF
    -DOSPRAY_APPS_ENABLE_SCRIPTING:BOOL=OFF
    -DOSPRAY_APPS_GLUTVIEWER:BOOL=OFF
    -DOSPRAY_APPS_PARAVIEW_TFN_CVT:BOOL=OFF
    -DOSPRAY_APPS_MODELVIEWER:BOOL=OFF
    -DOSPRAY_APPS_PARTICLEVIEWER:BOOL=OFF
    -DOSPRAY_APPS_QTVIEWER:BOOL=OFF
    -DOSPRAY_APPS_STREAMLINEVIEWER:BOOL=OFF
    -DOSPRAY_APPS_VOLUMEVIEWER:BOOL=OFF
    -DOSPRAY_COMMANDLINE_TACHYON_SUPPORT:BOOL=OFF
    -DOSPRAY_ENABLE_APPS:BOOL=OFF
    -DOSPRAY_ENABLE_TESTING:BOOL=OFF
    -DOSPRAY_ENABLE_TUTORIALS:BOOL=OFF
    -DOSPRAY_MODULE_DISPLAY_WALD:BOOL=OFF
    -DOSPRAY_MODULE_LOADERS:BOOL=OFF
    -DOSPRAY_MODULE_OPENGL_UTIL:BOOL=OFF
    -DOSPRAY_MODULE_SEISMIC:BOOL=OFF
    -DOSPRAY_MODULE_TACHYON:BOOL=OFF
    -DCMAKE_INSTALL_LIBDIR:STRING=lib)

superbuild_add_extra_cmake_args(
  -DOSPRAY_INSTALL_DIR:PATH=<INSTALL_DIR>)
superbuild_apply_patch(ospray type-conversion
    "Fix type conversion error on icc 18.")
superbuild_apply_patch(ospray fix-stale-constructor-call
    "Fixup constructor calls")
