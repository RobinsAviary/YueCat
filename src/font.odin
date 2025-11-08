package YueCat

import rl "vendor:raylib"
import lua "vendor:lua/5.4"
import "core:c"
import "core:fmt"
import "base:runtime"

LoadFont :: proc "c" (state: ^lua.State) -> (results: c.int) {
	filename := lua.L_checkstring(state, 1)

	font: rl.Font

	if lua.isinteger(state, 2) {
		font_size := c.int(lua.tointeger(state, 2))
		font = rl.LoadFontEx(filename, font_size, {}, 0)
	} else {
		font = rl.LoadFont(filename)
	}

	lua.checkstack(state, 1)
	data := cast(^rl.Font)lua.newuserdatauv(state, size_of(font), 0)
	lua.L_setmetatable(state, FontUData)

	data^ = font
	
	results = 1
	return
}

check_font :: proc "c" (state: ^lua.State, arg: c.int) -> (font: ^rl.Font) {
	user := lua.L_checkudata(state, arg, FontUData)
	font = cast(^rl.Font)user
	return
}

UnloadFont :: proc "c" (state: ^lua.State) -> (results: c.int) {
	font := check_font(state, 1)
	rl.UnloadFont(font^)
	return
}

GetDefaultFont :: proc "c" (state: ^lua.State) -> (results: c.int) {
	font := rl.GetFontDefault()

	lua.checkstack(state, 1)
	data := cast(^rl.Font)lua.newuserdatauv(state, size_of(font), 0)
	lua.L_setmetatable(state, FontUData)

	data^ = font

	results = 1

	return
}

DrawTextEx :: proc "c" (state: ^lua.State) -> (results: c.int) {
	font := check_font(state, 1)
	text := lua.L_checkstring(state, 2)
	position := check_vector2(state, 3)
	font_size := check_number_default(state, 4, f32(font.baseSize))
	spacing := check_number_default(state, 5, f32(font.glyphPadding))
	color := check_color(state, 6)

	rl.DrawTextEx(font^, text, position, f32(font_size), f32(spacing), color)

	return
}