package YueCat

import lua "vendor:lua/5.4"
import "core:time"
import "base:runtime"

push_time :: proc "c" (state: ^lua.State, pushed_time: time.Time) {
	context = runtime.default_context()

	lua.checkstack(state, 2)

	lua.createtable(state, 0, 1)

	lua.pushinteger(state, lua.Integer(pushed_time._nsec))
	lua.setfield(state, -2, "nsec")

	lua.checkstack(state, 2)

	lua.getglobal(state, "Vector2")
	lua.getfield(state, -1, "meta")

	lua.remove(state, -2)

	lua.setmetatable(state, -2)
}

to_time :: proc "c" (state: ^lua.State, idx: i32) -> (time: time.Time) {
	i := abs_idx(state, idx)

	lua.checkstack(state, 3)

	lua.getfield(state, i, "nsec")

	nsec := lua.tointeger(state, -1)

	lua.pop(state, 1)

	time = {i64(nsec)}

	return
}

check_time :: proc "c" (state: ^lua.State, arg: i32) -> (time: time.Time) {
	check_type(state, arg, "Time")
	time = to_time(state, arg)
	return
}