package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "base:runtime"

to_color :: proc "c" (state: ^lua.State, idx: i32) -> rl.Color {
	context = runtime.default_context()

	i := abs_idx(state, idx)

	lua.checkstack(state, 4)
	lua.getfield(state, i, "r")
	lua.getfield(state, i, "g")
	lua.getfield(state, i, "b")
	lua.getfield(state, i, "a")

	r := lua.tonumber(state, -4)
	g := lua.tonumber(state, -3)
	b := lua.tonumber(state, -2)
	a := lua.tonumber(state, -1)

	lua.pop(state, 4)

	return {scalar_to_u8(f32(r)), scalar_to_u8(f32(g)), scalar_to_u8(f32(b)), scalar_to_u8(f32(a))}
}

check_color :: proc "c" (state: ^lua.State, arg: i32) -> rl.Color {
	check_type(state, arg, "Color")
	return to_color(state, arg)
}

check_color_default :: proc "c" (state: ^lua.State, arg: i32, default: rl.Color) -> rl.Color {
	if lua.isnoneornil(state, arg) do return default

	return check_color(state, arg)
}

push_color :: proc "c" (state: ^lua.State, color: rl.Color) {
	context = runtime.default_context()

	lua.checkstack(state, 2)

	lua.createtable(state, 0, 1)

	lua.pushnumber(state, lua.Number(color.r) / 255)
	lua.setfield(state, -2, "r")
	lua.pushnumber(state, lua.Number(color.g) / 255)
	lua.setfield(state, -2, "g")
	lua.pushnumber(state, lua.Number(color.b) / 255)
	lua.setfield(state, -2, "b")
	lua.pushnumber(state, lua.Number(color.a) / 255)
	lua.setfield(state, -2, "a")

	lua.checkstack(state, 2)
	lua.getglobal(state, "Color")
	lua.getfield(state, -1, "meta")
	lua.remove(state, -2)
	lua.setmetatable(state, -2)
}