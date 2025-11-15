package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:fmt"
import "base:runtime"
import "core:c"

audio_warning :: proc "c" () {
	context = runtime.default_context()
	if !config.audio_active && !config.verbose {
		fmt.println("WARNING: Attempted to call audio function, but audio is disabled!")
	}
}

LoadAudio :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	if !config.audio_active {
		lua.checkstack(state, 1)

		lua.pushnil(state)
		results = 1
		return
	}
	fileName := lua.L_checkstring(state, 1)

	audio := rl.LoadSound(fileName)

	lua.checkstack(state, 1)
	data := cast(^rl.Sound)lua.newuserdatauv(state, size_of(audio), 0)
	lua.L_setmetatable(state, AudioUData)

	data^ = audio

	results = 1
	return
}

check_audio :: proc "c" (state: ^lua.State, arg: i32) -> (sound: ^rl.Sound) {
	user: rawptr
	
	if !is_type(state, arg, "Sound") {
		user = lua.L_checkudata(state, arg, AudioUData)
	} else {
		user = lua.L_checkudata(state, arg, SoundUData)
	}
	
	sound = cast(^rl.Sound)user

	return
}

UnloadAudio :: proc "c" (state: ^lua.State) -> (results: i32) {
	audio_warning()

	if config.audio_active {
		audio := check_audio(state, 1)

		rl.UnloadSound(audio^)
	}

	return
}