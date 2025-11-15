package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:c"

LoadRenderTexture :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)

	tex := rl.LoadRenderTexture(c.int(size.x), c.int(size.y))

	lua.checkstack(state, 1)
	data := cast(^rl.RenderTexture)lua.newuserdatauv(state, size_of(tex), 0)
	lua.L_setmetatable(state, RenderTextureUData)

	data^ = tex

	return 1
}

check_rendertexture :: proc "c" (state: ^lua.State, arg: i32) -> (texture: ^rl.RenderTexture) {
	user := lua.L_checkudata(state, arg, RenderTextureUData)
	texture = cast(^rl.RenderTexture)user
	return
}

UnloadRenderTexture :: proc "c" (state: ^lua.State) -> (results: c.int) {
	tex := check_rendertexture(state, 1)

	rl.UnloadRenderTexture(tex^)

	return
}