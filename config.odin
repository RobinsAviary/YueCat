package LuaCat

import rl "vendor:raylib"
import lua "vendor:lua/5.4"
import "core:strings"

Config :: struct {
	window_size: rl.Vector2,
	audio_active: bool,
	window_title: string,
}

config: Config

read_config :: proc (state: ^lua.State) -> (readConfig: Config) {
	lua.getglobal(state, "Config")
	
	lua.getfield(state, -1, "window")

	lua.getfield(state, -1, "title")
	readConfig.window_title = string(lua.tostring(state, -1))
	lua.pop(state, 1)

	lua.getfield(state, -1, "size")
	readConfig.window_size = to_vector2(state, -1)
	lua.pop(state, 1)
	
	lua.pop(state, 1)

	lua.getfield(state, -1, "audio")

	lua.getfield(state, -1, "active")

	readConfig.audio_active = bool(lua.toboolean(state, -1))

	lua.pop(state, 1)

	lua.pop(state, 1)
	
	lua.pop(state, 1)
	
	return
}