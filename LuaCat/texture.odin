package LuaCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"

LoadTexture :: proc "c" (state: ^lua.State) -> i32 {
	fileName := lua.L_checkstring(state, 1)
	
	texture := rl.LoadTexture(fileName)

	data := transmute(^rl.Texture)lua.newuserdatauv(state, size_of(texture), 0)
	lua.L_setmetatable(state, TextureUData)

	data.format = texture.format
	data.height = texture.height
	data.width = texture.width
	data.id = texture.id
	data.mipmaps = texture.mipmaps	
	//data = &texture
	
	return 1
}

check_texture :: proc "c" (state: ^lua.State, arg: i32) -> ^rl.Texture {
    user := lua.L_checkudata(state, arg, TextureUData)
    texture := transmute(^rl.Texture)user

    return texture
}

UnloadTexture :: proc "c" (state: ^lua.State) -> i32 {
	texture := check_texture(state, 1)

	rl.UnloadTexture(texture^)

	return 0
}