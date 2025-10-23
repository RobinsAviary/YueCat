package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "base:runtime"

to_camera :: proc "c" (state: ^lua.State, idx: i32) -> (camera: rl.Camera) {
    context = runtime.default_context()

	i := abs_idx(state, idx)

    lua.getfield(state, i, "position")
	lua.getfield(state, i, "target")
	lua.getfield(state, i, "up")
	lua.getfield(state, i, "fov")
    lua.getfield(state, i, "projection")

	/*r := lua.tonumber(state, -4)
	g := lua.tonumber(state, -3)
	b := lua.tonumber(state, -2)
	a := lua.tonumber(state, -1)*/
    
    return
}