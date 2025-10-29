package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"

Triangle :: struct {
	first_point: rl.Vector2,
	second_point: rl.Vector2,
	third_point: rl.Vector2,
}

to_triangle :: proc "c" (state: ^lua.State, idx: i32) -> (triangle: Triangle) {
	i := abs_idx(state, idx)

	lua.checkstack(state, 3)

	lua.getfield(state, i, "firstPoint")
	lua.getfield(state, i, "secondPoint")
	lua.getfield(state, i, "thirdPoint")

	firstPoint := to_vector2(state, -3)
	secondPoint := to_vector2(state, -2)
	thirdPoint := to_vector2(state, -1)

	lua.pop(state, 3)

	triangle = {firstPoint, secondPoint, thirdPoint}

	return
}

check_triangle :: proc "c" (state: ^lua.State, arg: i32) -> (triangle: Triangle) {
	check_type(state, arg, "Triangle")
	
	triangle = to_triangle(state, arg)
	
	return
}