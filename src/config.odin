package YueCat

import rl "vendor:raylib"
import lua "vendor:lua/5.4"
import "core:strings"
import "core:fmt"

Config :: struct {
	window_size: rl.Vector2,
	audio_active: bool,
	window_title: string,
	flags: ConfigFlags,
}

ConfigFlags :: struct {
	msaa: bool,
	borderless: bool,
	topmost: bool,
	resizable: bool,
	vsync: bool,
}

config: Config

read_config :: proc (state: ^lua.State) -> (readConfig: Config) {
	if VERBOSE do fmt.println("Reading config settings...")

	lua.checkstack(state, 1)
	lua.getglobal(state, "Config")
	
	// Window
	if VERBOSE do fmt.println("Reading window settings...")
	lua.checkstack(state, 3)
	lua.getfield(state, -1, "Window")

	lua.getfield(state, -1, "title")
	readConfig.window_title = string(lua.tostring(state, -1))
	lua.pop(state, 1)

	lua.getfield(state, -1, "size")
	readConfig.window_size = to_vector2(state, -1)
	lua.pop(state, 1)

	// Flags
	if VERBOSE do fmt.println("Reading window flags...")
	flags: ConfigFlags
	
	lua.checkstack(state, 6)
	
	lua.getfield(state, -1, "Flags")
	
	lua.getfield(state, -1, "msaa")
	flags.msaa = bool(lua.toboolean(state, -1))
	lua.pop(state, 1)

	lua.getfield(state, -1, "borderless")
	flags.borderless = bool(lua.toboolean(state, -1))
	lua.pop(state, 1)

	lua.getfield(state, -1, "topmost")
	flags.topmost = bool(lua.toboolean(state, -1))
	lua.pop(state, 1)

	lua.getfield(state, -1, "resizable")
	flags.resizable = bool(lua.toboolean(state, -1))
	lua.pop(state, 1)

	lua.getfield(state, -1, "vsync")
	flags.vsync = bool(lua.toboolean(state, -1))
	lua.pop(state, 1)

	lua.pop(state, 1) // Pop Flags

	config.flags = flags
	
	lua.pop(state, 1) // Pop Window

	// Audio
	if VERBOSE do fmt.println("Reading audio settings...")
	lua.checkstack(state, 2)
	lua.getfield(state, -1, "Audio")

	lua.getfield(state, -1, "active")
	readConfig.audio_active = bool(lua.toboolean(state, -1))
	lua.pop(state, 1) // Pop Active

	lua.pop(state, 1) // Pop Audio
	
	lua.pop(state, 1) // Pop Config
	
	return
}