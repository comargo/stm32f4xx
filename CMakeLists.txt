cmake_minimum_required(VERSION 2.8)
set(CMAKE_TOOLCHAIN_FILE arm-none-eabi.cmake)
project(STM32F4xx_HAL)
enable_language(ASM)

add_definitions(-DSTM32F411xE)

add_subdirectory(Drivers)
add_subdirectory(Middlewares)

add_library(syscalls OBJECT syscalls.c Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f411xe.s Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c)
target_include_directories(syscalls PUBLIC $<TARGET_PROPERTY:stm32f4xx_hal,INCLUDE_DIRECTORIES>)
set(syscalls_LIB_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/stm32f4xx.ld PARENT_SCOPE)
