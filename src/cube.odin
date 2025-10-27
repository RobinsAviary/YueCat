package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"

Cube :: struct {
	position: rl.Vector3,
	size: f32,
}

to_cube :: proc "c" (state: ^lua.State, idx: i32) -> Cube {
	i := abs_idx(state, idx)

	lua.checkstack(state, 2)
	lua.getfield(state, i, "position")
	lua.getfield(state, i, "size")

	position := to_vector3(state, -2)
	size := lua.tonumber(state, -1)

	lua.pop(state, 2)

	return {position, f32(size)}
}

check_cube :: proc "c" (state: ^lua.State, arg: i32) -> Cube {
	check_type(state, arg, "Cube")
	return to_cube(state, arg)
}