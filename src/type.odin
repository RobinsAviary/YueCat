package YueCat

import lua "vendor:lua/5.4"
import "base:runtime"
import "core:strings"
import "core:c"
import "core:slice"

is_type :: proc "c" (state: ^lua.State, idx: c.int, typeName: string) -> bool {
	context = runtime.default_context()
	realType := get_type(state, idx)
	return realType == typeName
}

is_types :: proc "c" (state: ^lua.State, idx: c.int, typeNames: []string) -> bool {
	context = runtime.default_context()
	realType := get_type(state, idx)
	return slice.contains(typeNames, realType)
}

check_type :: proc "c" (state: ^lua.State, idx: c.int, typeName: string) {
	context = runtime.default_context()
	if !is_type(state, idx, typeName) {
		errorMsg := strings.concatenate({"expected ", typeName, ", got ", get_type(state, idx)}, context.temp_allocator)

		lua.L_argerror(state, idx, strings.clone_to_cstring(errorMsg, context.temp_allocator))
	}
}

get_meta_name :: proc "c" (state: ^lua.State, idx: c.int) -> (typeName: string) {
	lua.checkstack(state, 1)
	if lua.L_getmetafield(state, idx, "__name") == c.int(lua.Type.STRING) {
		if lua.isstring(state, -1) {
			typeName = string(lua.tostring(state, -1))
		}
		lua.pop(state, 1)
	}

	return
}

get_type :: proc "c" (state: ^lua.State, idx: c.int) -> (typeName: string) {
	context = runtime.default_context()

	if lua.istable(state, idx) {
		typeName = get_meta_name(state, idx)
		return
	} else if lua.isuserdata(state, idx) {
		typeName = get_meta_name(state, idx)
		return
	}

	typeName = string(lua.L_typename(state, idx))
	return
}