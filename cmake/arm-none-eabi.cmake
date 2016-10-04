include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)

set(FLOAT_ABI "hard" CACHE STRING "Specifies which floating-point ABI to use")
set_property(CACHE FLOAT_ABI PROPERTY STRINGS soft softfp hard)

set(FLOAT_FLAGS "-mfloat-abi=${FLOAT_ABI}")
if(FLOAT_ABI STREQUAL "hard")
	set(FLOAT_FLAGS ${FLOAT_FLAGS} -mfpu=fpv4-sp-d16)
else()
	set(FLOAT_FLAGS -msoft-float)
endif()

cmake_force_c_compiler(arm-none-eabi-gcc GNU)
cmake_force_cxx_compiler(arm-none-eabi-g++ GNU)

set(arm_compile_link_options
    -mcpu=cortex-m4
    -mthumb
    -mthumb-interwork
    -mlittle-endian
    -fsingle-precision-constant
    -Wdouble-promotion
    ${FLOAT_FLAGS}
    "-T${CMAKE_CURRENT_LIST_DIR}/stm32f4xx.ld"
     -specs=nosys.specs
)
add_compile_options(${arm_compile_link_options})

string(REPLACE ";" " " CMAKE_C_LINK_FLAGS "${arm_compile_link_options}")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR})
