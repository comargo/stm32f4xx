cmake_minimum_required(VERSION 2.8)
set(CMAKE_TOOLCHAIN_FILE cmake/arm-none-eabi.cmake)
project(STM32F4xx_HAL)

add_subdirectory(Drivers)
add_subdirectory(Middlewares)

add_library(syscalls OBJECT syscalls.c)
set(syscalls_LIB_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/stm32f4xx.ld PARENT_SCOPE)
