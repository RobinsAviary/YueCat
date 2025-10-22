package LuaCat

import lua "vendor:lua/5.4"
import "base:runtime"
import "core:strings"
import "core:c"
import "core:slice"

is_type :: proc "c" (state: ^lua.State, idx: i32, typeName: string) -> bool {
	context = runtime.default_context()
	realType := get_type(state, idx)
	return realType == typeName
}

is_types :: proc "c" (state: ^lua.State, idx: i32, typeNames: []string) -> bool {
	context = runtime.default_context()
	realType := get_type(state, idx)
	return slice.contains(typeNames, realType)
}

check_type :: proc "c" (state: ^lua.State, idx: i32, typeName: string) {
	context = runtime.default_context()
	if !is_type(state, idx, typeName) {
		errorMsg := strings.concatenate({"expected ", typeName, ", got ", get_type(state, idx)}, context.temp_allocator)

		lua.L_argerror(state, idx, strings.clone_to_cstring(errorMsg, context.temp_allocator))
	}
}

get_type :: proc "c" (state: ^lua.State, idx: i32) -> (typeName: string) {
	context = runtime.default_context()
	metaTypeFound: bool = false

	if lua.istable(state, idx) {
		if lua.L_getmetafield(state, idx, "__name") != c.int(lua.Type.NIL) {
			if lua.isstring(state, -1) {
				typeName = string(lua.tostring(state, -1))
				metaTypeFound = true
			}
			lua.pop(state, 1)
		}
	}

	if !metaTypeFound do typeName = string(lua.L_typename(state, idx))
	return
}