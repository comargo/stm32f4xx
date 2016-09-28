cmake_minimum_required(VERSION 2.8)
set(CMAKE_TOOLCHAIN_FILE arm-none-eabi.cmake)
project(STM32F4xx_HAL)

add_definitions(-DSTM32F411xE)

add_subdirectory(Drivers)
add_subdirectory(Middlewares)
