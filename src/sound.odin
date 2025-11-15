package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:c"

LoadSound :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio := check_audio(state, 1)

	sound := rl.LoadSoundAlias(audio^)

	lua.checkstack(state, 1)
	data := cast(^rl.Sound)lua.newuserdatauv(state, size_of(sound), 0)
	lua.L_setmetatable(state, SoundUData)

	data^ = sound

	return 1
}

check_sound :: proc "c" (state: ^lua.State, arg: i32) -> (sound: ^rl.Sound) {
	user := lua.L_checkudata(state, arg, SoundUData)
	sound = cast(^rl.Sound)user
	return
}

UnloadSound :: proc "c" (state: ^lua.State) -> (results: c.int) {
	sound := check_sound(state, 1)

	rl.UnloadSoundAlias(sound^)

	return
}