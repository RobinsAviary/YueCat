package YueCat

import lua "vendor:lua/5.4"
import "core:fmt"
import "core:strings"
import os "core:os/os2"
import "core:path/filepath"

TextureUData :: "Texture"
AudioUData :: "Audio"
ControllerUData :: "Controller"
FontUData :: "Font"
MusicUData :: "Music"
RenderTextureUData :: "RenderTexture"
SoundUData :: "Sound"
ImageUData :: "Image"

NAME :: "YueCat"
VERSION :: "Alpha (Pre-Release 1)"

program_location := "program/"
// Includes .
LUA_EXTENSION :: ".lua"
MAIN_FILE :: "main" + LUA_EXTENSION

// os.get_current_directory()

open_base :: proc(state: ^lua.State) {
	// Generate lua files
	
	base_path, base_path_allocated := filepath.from_slash("resources/base/")
	base_directory := strings.concatenate({config.runtime_location, base_path})

	if config.verbose do fmt.printfln("Base directory: \"%s\"", base_directory)

	run_yuescript(base_directory)

	// Run lua files

	handle, error := os.open(base_directory)

	delete(base_directory)
	if base_path_allocated do delete(base_path)

	if error != os.ERROR_NONE {
		fmt.println(error)
	}

	files, err := os.read_dir(handle, 0, context.allocator)

	if err != os.ERROR_NONE {
		fmt.println(err)
	}

	for file in files {
		if strings.ends_with(file.name, LUA_EXTENSION) {
			do_file(state, file.fullpath)
		}
	}

	delete(files)

	os.close(handle)
}

metatables: []string = {TextureUData, AudioUData, ControllerUData, FontUData, MusicUData, RenderTextureUData, SoundUData}

register_metatables :: proc(state: ^lua.State) {
	if config.verbose do fmt.println("Registering metatables...")

	metatables_len := i32(len(metatables))

	lua.checkstack(state, metatables_len)
	for metatable in metatables {
		lua.L_newmetatable(state, strings.clone_to_cstring(metatable, context.temp_allocator))
	}
	lua.pop(state, metatables_len)

	free_all(context.temp_allocator)
}

new_state :: proc() -> ^lua.State {
	state := lua.L_newstate()

	lua.L_openlibs(state)

	// Todo: Open these libraries properly so the user doesn't have direct access to the OS library.
	//lua.open_math(state)
	//lua.open_string(state)
	//lua.open_table(state)
	//lua.open_coroutine(state)

	open_base(state)
	
	register_functions(state)

	register_metatables(state)

	return state
}

print_stack :: proc(state: ^lua.State) {
	fmt.printfln("Stack size: %d", lua.gettop(state))
}

main :: proc() {
	process_console_args()

	init_config()

	state := new_state()

	main_loop(state)

	if !config.crashed {
		print_stack(state)
	}

	lua.close(state)

	if config.crashed do throw_error(.LUA_CRASHED)
}