package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:c"

to_rectangle :: proc "c" (state: ^lua.State, idx: c.int) -> (rectangle: rl.Rectangle) {
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

check_rectangle :: proc "c" (state: ^lua.State, arg: c.int) -> (rectangle: rl.Rectangle) {
	check_type(state, arg, "Rectangle")
	rectangle = to_rectangle(state, arg)
	return
}

check_rectangle_default :: proc "c" (state: ^lua.State, arg: c.int, default: rl.Rectangle) -> (rectangle: rl.Rectangle) {
	if lua.isnoneornil(state, arg) {
		rectangle = default
	} else {
		rectangle = check_rectangle(state, arg)
	}

	return
}

push_rectangle :: proc "c" (state: ^lua.State, rectangle: rl.Rectangle) {
	lua.checkstack(state, 1)

	lua.createtable(state, 0, 2)

	lua.checkstack(state, 2)
	push_vector2(state, {rectangle.x, rectangle.y})
	lua.setfield(state, -2, "position")

	push_vector2(state, {rectangle.width, rectangle.height})
	lua.setfield(state, -2, "size")

	lua.checkstack(state, 2)

	lua.getglobal(state, "Rectangle")
	lua.getfield(state, -1, "meta")

	lua.remove(state, -2)

	lua.setmetatable(state, -2)
}