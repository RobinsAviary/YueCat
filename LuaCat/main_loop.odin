package LuaCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:fmt"
import "core:strings"

init_loop :: proc(state: ^lua.State) {
	do_file(state, "program/main.lua")

	CallEngineFunc(state, "Init")

	config = read_config(state)

	title := strings.clone_to_cstring(config.window_title)

	rl.InitWindow(i32(config.window_size.x), i32(config.window_size.y), title)

	delete(title)

	if config.audio_active do rl.InitAudioDevice()

	CallEngineFunc(state, "Ready")
}

main_loop :: proc(state: ^lua.State) {
	init_loop(state)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		CallEngineFunc(state, "Step")

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
}