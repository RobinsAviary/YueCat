package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "base:runtime"

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

	lua.checkstack(state, 3)

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