package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:c"

LoadTexture :: proc "c" (state: ^lua.State) -> (results: c.int) {
	fileName := lua.L_checkstring(state, 1)
	
	texture := rl.LoadTexture(fileName)

	lua.checkstack(state, 1)
	data := cast(^rl.Texture)lua.newuserdatauv(state, size_of(texture), 0)
	lua.L_setmetatable(state, TextureUData)

	data^ = texture
	
	results = 1
	return
}

check_texture :: proc "c" (state: ^lua.State, arg: i32) -> (texture: ^rl.Texture) {
	user := lua.L_checkudata(state, arg, TextureUData)
	texture = cast(^rl.Texture)user
	return
}

UnloadTexture :: proc "c" (state: ^lua.State) -> (results: c.int) {
	texture := check_texture(state, 1)
	rl.UnloadTexture(texture^)
	return
}