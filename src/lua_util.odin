package YueCat

import lua "vendor:lua/5.4"
import "core:c"
import "core:strings"
import "core:fmt"

pop_error :: proc(state: ^lua.State) {
	error := lua.tostring(state, -1)
	lua.pop(state, 1)
	fmt.println(error)
}

do_file :: proc(state: ^lua.State, filename: string) -> (succeeded: bool = false) {
	if lua.L_loadfile(state, strings.clone_to_cstring(filename, context.temp_allocator)) == .OK {
		if lua.pcall(state, 0, 0, 0) != 0 {
			pop_error(state)
		} else {
			succeeded = true
		}
	} else {
		pop_error(state)
	}

	return
}

do_string :: proc(state: ^lua.State, code: string) -> (succeeded: bool = false) {
	if lua.L_loadstring(state, strings.clone_to_cstring(code, context.temp_allocator)) == .OK {
		if lua.pcall(state, 0, 0, 0) != 0 {
			pop_error(state)
		} else {
			succeeded = true
		}
	} else {
		pop_error(state)
	}

	return
}

register :: proc(state: ^lua.State, c_function: lua.CFunction, name: string, obj: c.int = -2) {
	//lua.checkstack(state, 1)

	lua.pushcfunction(state, c_function)

	lua.setfield(state, obj, strings.clone_to_cstring(name, context.temp_allocator))
}

@(require_results)
pcall :: proc(state: ^lua.State, args: c.int = 0, results: c.int = 0, errfunc: c.int = 0) -> (suceeded: bool) {
	if (lua.pcall(state, args, results, errfunc) != 0) {
		pop_error(state)
	} else {
		suceeded = true
	}

	return
}

@(require_results)
CallEngineFunc :: proc(state: ^lua.State, functionName: string) -> (succeeded: bool) {
	lua.checkstack(state, 2)
	lua.getglobal(state, "Engine")
	lua.getfield(state, -1, strings.clone_to_cstring(functionName, context.temp_allocator))

	succeeded = pcall(state)

	lua.pop(state, 1)

	return
}

abs_idx :: proc "c" (state: ^lua.State, idx: i32) -> i32 {
	if idx >= 0 {
		return idx
	} else {
		return lua.gettop(state) + (idx + 1)
	}
}