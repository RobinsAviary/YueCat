package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "base:runtime"
import "core:c"

to_vector2 :: proc "c" (state: ^lua.State, idx: i32) -> (vector: rl.Vector2) {
	i := abs_idx(state, idx)
	
	lua.checkstack(state, 2)
	lua.getfield(state, i, "x")
	lua.getfield(state, i, "y")

	x := lua.tonumber(state, -2)
	y := lua.tonumber(state, -1)

	lua.pop(state, 2)

	vector = {f32(x), f32(y)}

	return
}

check_vector2 :: proc "c" (state: ^lua.State, arg: i32) -> (vector: rl.Vector2) {
	check_type(state, arg, "Vector2")
	vector = to_vector2(state, arg)
	return
}

check_vector2_default :: proc "c" (state: ^lua.State, arg: i32, default: rl.Vector2) -> (vector: rl.Vector2) {
	if lua.isnoneornil(state, arg) do return default
	vector = check_vector2(state, arg)
	return
}

push_vector2 :: proc "c" (state: ^lua.State, vector: rl.Vector2) {
	context = runtime.default_context()

	lua.checkstack(state, 2)

	lua.createtable(state, 0, 2)

	lua.pushnumber(state, lua.Number(vector.x))
	lua.setfield(state, -2, "x")
	lua.pushnumber(state, lua.Number(vector.y))
	lua.setfield(state, -2, "y")

	lua.checkstack(state, 2)

	lua.getglobal(state, "Vector2")
	lua.getfield(state, -1, "meta")

	lua.remove(state, -2)

	lua.setmetatable(state, -2)
}

check_list_vector2 :: proc (state: ^lua.State, arg: c.int, allocator := context.allocator, loc := #caller_location) -> (list: []rl.Vector2) {
	lua.L_checktype(state, arg, c.int(lua.Type.TABLE))

	lua.len(state, arg)
	if !lua.isinteger(state, -1) {
		lua.L_error(state, "List did not return an integer for length.")
	}
	list_length := lua.tointeger(state, -1)

	list = make([]rl.Vector2, int(list_length), allocator, loc)

	for &item, i in list {
		lua.pushinteger(state, lua.Integer(i + 1))
		lua.gettable(state, 1)

		if !is_type(state, -1, "Vector2") {
			lua.L_error(state, "Table contained something that isn't a Vector2!")
		}

		item = to_vector2(state, -1)

		lua.pop(state, 1)
	}

	return
}