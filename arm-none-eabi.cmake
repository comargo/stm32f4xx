INCLUDE(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)

CMAKE_FORCE_C_COMPILER(/usr/bin/arm-none-eabi-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(/usr/bin/arm-none-eabi-g++ GNU)

SET(COMMON_FLAGS "-mcpu=cortex-m4 -mthumb -mthumb-interwork -msoft-float -ffunction-sections -fdata-sections -g -fno-common -fmessage-length=0")
SET(CMAKE_C_FLAGS "${COMMON_FLAGS}")
SET(CMAKE_CXX_FLAGS "${COMMON_FLAGS}")
