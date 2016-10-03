include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)

set(CPU "cortex-m4" CACHE STRING "Specifies the name of the target ARM processor.")
set_property(CACHE CPU PROPERTY STRINGS cortex-m0 cortex-m0plus cortex-m1 cortex-m3 cortex-m4 cortex-m7 cortex-r4)

set(FLOAT_ABI "softfp" CACHE STRING "Specifies which floating-point ABI to use")
set_property(CACHE FLOAT_ABI PROPERTY STRINGS soft softfp hard)

set(FLOAT_FLAGS "-mfloat-abi=${FLOAT_ABI}")
if(FLOAT_ABI STREQUAL "hard")
	set(FLOAT_FLAGS ${FLOAT_FLAGS} -mfpu=fpv4-sp-d16)
else()
	set(FLOAT_FLAGS -msoft-float)
endif()

cmake_force_c_compiler(arm-none-eabi-gcc GNU)
cmake_force_cxx_compiler(arm-none-eabi-g++ GNU)
add_compile_options(-mlittle-endian -mthumb -nostartfiles -mcpu=${CPU} -fsingle-precision-constant -Wdouble-promotion ${FLOAT_FLAGS})
string(REPLACE ";" " " FLOAT_FLAGS_STR "${FLOAT_FLAGS}")
set(CMAKE_C_LINK_FLAGS "-mcpu=${CPU} -mthumb -mthumb-interwork -mlittle-endian ${FLOAT_FLAGS_STR} -T${CMAKE_CURRENT_LIST_DIR}/stm32f4xx.ld")
