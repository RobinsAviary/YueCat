package YueCat

import rl "vendor:raylib"
import lua "vendor:lua/5.4"

Circle :: struct {
	position: rl.Vector2,
	diameter: f32,
}

to_circle :: proc "c" (state: ^lua.State, idx: i32) -> (circle: Circle) {
	i := abs_idx(state, idx)

	lua.checkstack(state, 2)
	lua.getfield(state, i, "position")
	lua.getfield(state, i, "radius")

	position := to_vector2(state, -2)
	radius := lua.tonumber(state, -1)

	lua.pop(state, 2)

	circle = {position, f32(radius)}

	return
}

check_circle :: proc "c" (state: ^lua.State, arg: i32) -> (circle: Circle) {
	check_type(state, arg, "Circle")
	circle = to_circle(state, arg)
	return
}