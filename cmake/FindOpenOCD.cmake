find_program(OpenOCD_EXE NAMES openocd)
if(NOT OpenOCD_EXE_FOUND)
	set(OpenOCD_FOUND FALSE)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenOCD
	FOUND_VAR OpenOCD_FOUND
	REQUIRED_VARS
		OpenOCD_EXE
)

set(gdbinit_file ${CMAKE_CURRENT_LIST_DIR}/gdbinit)
function(enable_deploy TARGET)
	add_custom_command(
		TARGET ${TARGET} POST_BUILD
		COMMENT "Deploying to board"
		COMMAND ${OpenOCD_EXE} ARGS -f board/st_nucleo_f4.cfg -c \" program $<TARGET_FILE:${TARGET}> verify reset exit \"
	)
endfunction(enable_deploy)

function(add_deploy_target TARGET)
	add_custom_target(deploy_${TARGET}
		COMMENT "Deploying to board"
		COMMAND ${OpenOCD_EXE} ARGS -f board/st_nucleo_f4.cfg -c \" program $<TARGET_FILE:${TARGET}> verify reset exit \"
	)
	add_dependencies(deploy_${TARGET} ${TARGET})
endfunction(add_deploy_target)

function(add_debug_target TARGET)
	add_custom_target(debug_${TARGET}
		COMMENT "Running debugger"
		COMMAND arm-none-eabi-gdb -ex \" target remote | ${OpenOCD_EXE} -f board/st_nucleo_f4.cfg -c \\\"gdb_port pipe\\\" \" -x ${gdbinit_file} $<TARGET_FILE:${TARGET}>
	)
	add_dependencies(debug_${TARGET} deploy_${TARGET})
endfunction(add_debug_target)
