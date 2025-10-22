package LuaCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:fmt"
import "core:strings"
import os "core:os/os2"

init_loop :: proc(state: ^lua.State) {
	fmt.println("Building YueScripts...")

	processState, stdout, stderr, err := os.process_exec({"vendor/", {"yue.exe", "..\\" + PROGRAM}, nil, nil, nil, nil}, context.allocator)

	fmt.println(string(stdout))

	if err != nil {
		fmt.println("Something went wrong trying to run the YueScript compiler. Is it in 'vendor\\'?")
		fmt.println(err)
		os.exit(1)
	}

	// Success flag seemingly isn't triggered properly. Added more specific check, but I'm leaving the first one just in case.
	if !processState.success || processState.exit_code != 0 {
		fmt.println(string(stderr))
		os.exit(processState.exit_code)
	}

	delete(stdout)
	delete(stderr)

	do_file(state, PROGRAM + "main.lua")

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