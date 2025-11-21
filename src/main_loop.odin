package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:fmt"
import "core:strings"
import sdl "vendor:sdl2"
import os "core:os/os2"
import "core:path/filepath"

Error :: enum {
	NO_SLASH_RUNTIME = 1,
	FIND_EXECUTABLE_PATH,
	SDL_INIT_FAILED,
	YUESCRIPT_COMPILER_FAILED,
	UNSUPPORTED_OS,
}
throw_error :: proc(error: Error) {
	fmt.println("Error Code:", error)
	os.exit(int(error))
}

find_runtime_location :: proc(allocator := context.allocator) -> string {
	loc, error := os.get_executable_path(allocator)
	
	if error != nil {
		fmt.println("Something went wrong while trying to access the runtime's location!")
		fmt.println(error)
		throw_error(.FIND_EXECUTABLE_PATH)
	}
	
	loc, _ = filepath.to_slash(loc, allocator)
	end_index := strings.last_index(loc, "/")
	if end_index == -1 {
		fmt.println("Unable to find a slash for the runtime location!")
		fmt.printfln("Input was: %s", loc)
		throw_error(.NO_SLASH_RUNTIME)
	}
	path, ok := strings.substring_to(loc, end_index + 1)
	if !ok {
		fmt.println("Indexed out of bounds while trying to get runtime location!")
		fmt.printfln("Input was: %s", loc)
	}

	path, _ = filepath.from_slash(path, allocator)

	return path
}

init_config :: proc() {
	config.runtime_location = find_runtime_location(context.allocator)

	config.default_deadzone = 0.15
	config.verbose = true

	if config.verbose do fmt.printfln("Runtime location: \"%s\"", config.runtime_location)
}

init_loop :: proc(state: ^lua.State) {
	run_yuescript(program_location)

	program_main_file := strings.concatenate({program_location, "main.lua"})

	do_file(state, program_main_file)

	delete(program_main_file)

	program_folder, program_folder_allocated := filepath.from_slash(program_location)

	c_program_folder := strings.clone_to_cstring(program_folder)

	rl.ChangeDirectory(c_program_folder)

	delete(c_program_folder)
	if program_folder_allocated do delete(program_folder)

	if !config.crashed {
		config.crashed |= !CallEngineFunc(state, "Init")
	}
	if config.crashed do return

	// Update our config based on user settings
	read_config(state, &config)

	title := strings.clone_to_cstring(config.window_title)

	// TODO: Add config to disable controllers
	init_sdl()

	flags: rl.ConfigFlags

	if config.flags.msaa do flags |= {.MSAA_4X_HINT}

	if config.flags.borderless do flags |= {.BORDERLESS_WINDOWED_MODE}

	if config.flags.resizable do flags |= {.WINDOW_RESIZABLE}

	if config.flags.topmost do flags |= {.WINDOW_TOPMOST}

	if config.flags.vsync do flags |= {.VSYNC_HINT}

	rl.SetConfigFlags(flags)

	rl.InitWindow(i32(config.window_size.x), i32(config.window_size.y), title)

	delete(title)

	if config.audio_active do rl.InitAudioDevice()

	if !config.crashed {
		config.crashed |= !CallEngineFunc(state, "Ready")
	}
}

clear_controller_buttons :: proc() {
	for _, &controller in controllers {
		controller.pressed = {}
		controller.released = {}
	}
}

main_loop :: proc(state: ^lua.State) {
	init_loop(state)

	if config.crashed do return

	for !rl.WindowShouldClose() {
		if config.crashed {
			rl.CloseWindow()
			continue
		}

		poll_events(state)
		sdl.GameControllerUpdate()

		config.crashed |= !CallEngineFunc(state, "Step")

		rl.BeginDrawing()
		config.crashed |= !CallEngineFunc(state, "Draw")
		rl.EndDrawing()

		free_all(context.temp_allocator)

		clear_controller_buttons()
	}

	if config.crashed do return

	cleanup_loop(state)
}

cleanup_loop :: proc(state: ^lua.State) {
	if !config.crashed {
		config.crashed |= !CallEngineFunc(state, "Cleanup")
	}

	if config.audio_active do rl.CloseAudioDevice()

	rl.CloseWindow()

	cleanup_sdl()

	delete(config.runtime_location, context.allocator)

	delete(controllers)
}