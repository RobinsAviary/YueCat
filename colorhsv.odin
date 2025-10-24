package YueCat

import lua "vendor:lua/5.4"
import "base:runtime"

ColorHSV :: struct {
	h: f32,
	s: f32,
	v: f32,
	a: u8,
}

to_color_hsv :: proc "c" (state: ^lua.State, idx: i32) -> ColorHSV {
	context = runtime.default_context()

	i := abs_idx(state, idx)

	lua.checkstack(state, 4)

	lua.getfield(state, i, "h")
	lua.getfield(state, i, "s")
	lua.getfield(state, i, "v")
	lua.getfield(state, i, "a")

	h := lua.tonumber(state, -4)
	s := lua.tonumber(state, -3)
	v := lua.tonumber(state, -2)
	a := lua.tonumber(state, -1)

	lua.pop(state, 4)

	lua.checkstack(state, 2)

	lua.getglobal(state, "ColorHSV")
	lua.getfield(state, -1, "meta")

	lua.remove(state, -2)

	lua.setmetatable(state, -2)

	return {f32(h), f32(s), f32(v), scalar_to_u8(f32(a))}
}

check_color_hsv :: proc "c" (state: ^lua.State, arg: i32) -> ColorHSV {
	check_type(state, arg, "ColorHSV")
	return to_color_hsv(state, arg)
}

push_color_hsv :: proc "c" (state: ^lua.State, color: ColorHSV) {
	context = runtime.default_context()

	lua.checkstack(state, 2)

	lua.createtable(state, 0, 1)

	lua.pushnumber(state, lua.Number(color.h))
	lua.setfield(state, -2, "h")
	lua.pushnumber(state, lua.Number(color.s))
	lua.setfield(state, -2, "s")
	lua.pushnumber(state, lua.Number(color.v))
	lua.setfield(state, -2, "v")
	lua.pushnumber(state, lua.Number(color.a) / 255)
	lua.setfield(state, -2, "a")

	lua.checkstack(state, 2)

	lua.getglobal(state, "ColorHSV")
	lua.getfield(state, -1, "meta")

	lua.remove(state, -2)

	lua.setmetatable(state, -2)
}