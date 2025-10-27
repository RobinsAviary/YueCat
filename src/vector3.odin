package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"

to_vector3 :: proc "c" (state: ^lua.State, idx: i32) -> rl.Vector3 {
	i := abs_idx(state, idx)

	lua.checkstack(state, 3)
	
	lua.getfield(state, i, "x")
	lua.getfield(state, i, "y")
	lua.getfield(state, i, "z")

	x := lua.tonumber(state, -3)
	y := lua.tonumber(state, -2)
	z := lua.tonumber(state, -1)

	lua.pop(state, 3)

	return {f32(x), f32(y), f32(z)}
}

check_vector3 :: proc "c" (state: ^lua.State, arg: i32) -> rl.Vector3 {
	check_type(state, arg, "Vector3")
	return to_vector3(state, arg)
}

check_vector3_default :: proc "c" (state: ^lua.State, arg: i32, default: rl.Vector3) -> rl.Vector3 {
	if lua.isnoneornil(state, arg) do return default

	return check_vector3(state, arg)
}