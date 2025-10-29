package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:fmt"
import "core:strings"
import sdl "vendor:sdl2"

init_loop :: proc(state: ^lua.State) {
	build_yuescript()

	do_file(state, PROGRAM + "main.lua")

	config.default_deadzone = 0.15
	config.verbose = true

	CallEngineFunc(state, "Init")

	config = read_config(state)

	// TODO: Add config to disable controllers
	init_sdl()

	flags: rl.ConfigFlags

	if config.flags.msaa do flags |= {.MSAA_4X_HINT}

	if config.flags.borderless do flags |= {.BORDERLESS_WINDOWED_MODE}

	if config.flags.resizable do flags |= {.WINDOW_RESIZABLE}

	if config.flags.topmost do flags |= {.WINDOW_TOPMOST}

	if config.flags.vsync do flags |= {.VSYNC_HINT}

	rl.SetConfigFlags(flags)

	title := strings.clone_to_cstring(config.window_title)

	rl.InitWindow(i32(config.window_size.x), i32(config.window_size.y), title)

	delete(title)

	if config.audio_active do rl.InitAudioDevice()

	CallEngineFunc(state, "Ready")
}

main_loop :: proc(state: ^lua.State) {
	init_loop(state)

	for !rl.WindowShouldClose() {
		poll_events(state)
		sdl.GameControllerUpdate()

		CallEngineFunc(state, "Step")

		rl.BeginDrawing()
		CallEngineFunc(state, "Draw")
		rl.EndDrawing()

		free_all(context.temp_allocator)
		lua.gc(state, .COLLECT) // Do a garbage collection cycle after each frame, just in case.
	}

	cleanup_loop(state)
}

cleanup_loop :: proc(state: ^lua.State) {
	CallEngineFunc(state, "Cleanup")

	if config.audio_active do rl.CloseAudioDevice()

	rl.CloseWindow()

	cleanup_sdl()

	delete(controllers)
}