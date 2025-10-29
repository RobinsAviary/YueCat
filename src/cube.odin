package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"

Cube :: struct {
	position: rl.Vector3,
	size: f32,
}

to_cube :: proc "c" (state: ^lua.State, idx: i32) -> (cube: Cube) {
	i := abs_idx(state, idx)

	lua.checkstack(state, 2)
	lua.getfield(state, i, "position")
	lua.getfield(state, i, "size")

	position := to_vector3(state, -2)
	size := lua.tonumber(state, -1)

	lua.pop(state, 2)

	cube = {position, f32(size)}

	return
}

check_cube :: proc "c" (state: ^lua.State, arg: i32) -> (cube: Cube) {
	check_type(state, arg, "Cube")
	cube = to_cube(state, arg)
	return
}