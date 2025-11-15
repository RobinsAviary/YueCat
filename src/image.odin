package YueCat

import rl "vendor:raylib"
import lua "vendor:lua/5.4"
import "core:c"

LoadImage :: proc "c" (state: ^lua.State) -> (results: c.int) {
	filename := lua.L_checkstring(state, 1)
	
	img := rl.LoadImage(filename)

	lua.checkstack(state, 1)
	push_image(state, &img)
	
	return 1
}

push_image :: proc "c" (state: ^lua.State, image: ^rl.Image) {
	data := lua.newuserdatauv(state, size_of(image), 0)
	lua.L_setmetatable(state, ImageUData)
	
	data = image
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