package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:c"

LoadMusic :: proc "c" (state: ^lua.State) -> (results: c.int) {
	fileName := lua.L_checkstring(state, 1)

	music := rl.LoadMusicStream(fileName)

	lua.checkstack(state, 1)
	data := cast(^rl.Music)lua.newuserdatauv(state, size_of(music), 0)
	lua.L_setmetatable(state, MusicUData)

	data^ = music

	results = 1
	return
}

check_music :: proc "c" (state: ^lua.State, arg: c.int) -> (music: ^rl.Music) {
	user := lua.L_checkudata(state, arg, MusicUData)
	music = cast(^rl.Music)user

	return
}

UnloadMusic :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)
	
	rl.UnloadMusicStream(music^)

	return
}