package LuaCat

import lua "vendor:lua/5.4"
import "core:fmt"
import "core:strings"
import os "core:os/os2"

TextureUData :: "Texture"
AudioUData :: "Audio"

NAME :: "LuaCat"
VERSION :: "Alpha"

PROGRAM :: "program\\"
// Includes .
LUA_EXTENSION :: ".lua"
MAIN_FILE :: "main" + LUA_EXTENSION

open_base :: proc(state: ^lua.State) {
	handle, error := os.open("base")

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

	lua.L_newmetatable(state, TextureUData)
	lua.pop(state, 1)

	lua.L_newmetatable(state, AudioUData)
	lua.pop(state, 1)

	return state
}

print_stack :: proc(state: ^lua.State) {
	fmt.printfln("Final stack size: %d", lua.gettop(state))
}

main :: proc() {
	state := new_state()

	main_loop(state)

	print_stack(state)

	lua.close(state)
}