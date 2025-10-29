package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"

to_rectangle :: proc "c" (state: ^lua.State, idx: i32) -> (rectangle: rl.Rectangle) {
	i := abs_idx(state, idx)

	lua.checkstack(state, 2)

	lua.getfield(state, i, "position")
	lua.getfield(state, i, "size")

	position := to_vector2(state, -2)
	size := to_vector2(state, -1)

	lua.pop(state, 2)

	rectangle = {position.x, position.y, size.x, size.y}

	return
}

check_rectangle :: proc "c" (state: ^lua.State, arg: i32) -> (rectangle: rl.Rectangle) {
	check_type(state, arg, "Rectangle")
	rectangle = to_rectangle(state, arg)
	return
}