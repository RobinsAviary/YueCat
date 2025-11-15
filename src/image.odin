package YueCat

import rl "vendor:raylib"
import lua "vendor:lua/5.4"
import "core:c"

LoadImage :: proc "c" (state: ^lua.State) -> (results: c.int) {
	filename := lua.L_checkstring(state, 1)
	
	img := rl.LoadImage(filename)
	
	lua.checkstack(state, 1)
	lua.newuserdatauv(state, size_of(img), 0)
	lua.L_setmetatable(state, ImageUData)

	return 1
}

check_image :: proc "c" (state: ^lua.State, arg: i32) -> (image: ^rl.Image) {
	user := lua.L_checkudata(state, arg, ImageUData)
	image = cast(^rl.Image)user
	return
}

UnloadImage :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)

	rl.UnloadImage(image^)

	return
}