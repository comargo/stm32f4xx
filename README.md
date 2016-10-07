STM32F4 Hardware Abstraction Library
====================================

It's a copy of STM32F4 HAL wrapped to static library using cmake

Additionally it provides:
* Toolchain file cmake/arm-none-eabi.cmake
* OpenOCD caller for deploy and debug

CMake Toolchain File
--------------------
CMake Toolchain file provides set of compiler and linker flags for "arm-non-eabi-gcc" compiler

To use the toolchain file one should either call cmake with `-DCMAKE_TOOLCHAIN_FILE=<path>/cmake/arm-none-eabi.cmake` 
or specify `CMAKE_TOOLCHAIN_FILE` variable in CMakeLists.txt file before `project()` command:

	cmake_minimum_required(VERSION 2.8)
	set(CMAKE_TOOLCHAIN_FILE ../STM32F4xx_DSP_StdPeriph_Lib/cmake/arm-none-eabi.cmake)
	project(test1)

OpenOCD caller
--------------
There is a `FindOpenOCD.cmake` module that searches for `openocd` binary and provides option to add deploy and debug target.

The path to FindOpenOCD.cmake module is automatically added by toolchain file.

### OpenOCD deployment

*Note:*

For now the OpenOCD flags are set to `st_nucleo_f4` board.

There are two option to deploy target to board:

#### Post-build command

`enable_deploy()` command adds deployment command as Post-build command.

Sample usage:

	find_package(OpenOCD REQUIRED)
	add_executable(test1 main.c)
	enable_deploy(test1)

In this case building executable will call `openocd` to deploy binary to board.

#### Deploy target

`add_deploy_target()` command adds deployment target `deploy_${TARGET}` that depends on `${TARGET}`.

Sample usage:

	find_package(OpenOCD REQUIRED)
	add_executable(test1 main.c)
	add_deploy_target(test1)

Calling:

	$ make deploy_test1

### OpenOCD debuging

`add_debug_target()` command adds debuging target `debug_${TARGET}` that depends either on `deploy_${TARGET}` or on `${TARGET}`

If deployment is neither enabled (post-build) neither added, it automatically adds `deploy_${TARGET}`.

Sample usage:

	find_package(OpenOCD REQUIRED)
	add_executable(test1 main.c)
	add_debug_target(test1)

Calling:

	$ make debug_test1


