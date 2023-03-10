include(CheckIncludeFile)
set(PACKAGE_CONFIG_TEXT "Vapoursynth include directory")

if(WIN32)
    get_filename_component(VS_FOLDER "[HKEY_LOCAL_MACHINE\\SOFTWARE\\VapourSynth;Path]" ABSOLUTE)
    if (NOT VS_FOLDER MATCHES "/registry") # registry stuff in CMake is pretty obscure
        check_include_file("${VS_FOLDER}/sdk/include/vapoursynth/VapourSynth4.h" HAVE_API4_INSTALLATION)
        if (HAVE_API4_INSTALLATION)
            set(VPY_INCLUDE_DIR "${VS_FOLDER}/sdk/include" CACHE PATH "${PACKAGE_CONFIG_TEXT}")
        endif()
    endif()
else()
    find_path(VPY_INCLUDE_PREFIX NAMES vapoursynth PATHS usr PATH_SUFFIXES include)
    if(VPY_INCLUDE_PREFIX)
        check_include_file("vapoursynth/VapourSynth4.h" HAVE_API4_INSTALLATION)
        if (HAVE_API4_INSTALLATION)
            set(VPY_INCLUDE_DIR "${VPY_INCLUDE_PREFIX}" CACHE PATH "${PACKAGE_CONFIG_TEXT}")
        endif()
    endif()
endif()

if(VPY_INCLUDE_DIR)
    set(Vapoursynth_FOUND 1)
    message(STATUS "${PACKAGE_CONFIG_TEXT}: ${VPY_INCLUDE_DIR}")
else()
    set(Vapoursynth_FOUND 0)
    set(VPY_INCLUDE_DIR "VPY_INCLUDE_DIR-NOTFOUND" CACHE PATH "${PACKAGE_CONFIG_TEXT}")
    message(STATUS "${PACKAGE_CONFIG_TEXT} NOT found")
endif()
