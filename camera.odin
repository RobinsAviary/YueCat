package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "base:runtime"

to_camera :: proc "c" (state: ^lua.State, idx: i32) -> (camera: rl.Camera3D) {
    context = runtime.default_context()

	i := abs_idx(state, idx)

	lua.checkstack(state, 5)

    lua.getfield(state, i, "position")
	lua.getfield(state, i, "target")
	lua.getfield(state, i, "up")
	lua.getfield(state, i, "fov")
    lua.getfield(state, i, "projection")

	position := to_vector3(state, -5)
	target := to_vector3(state, -4)
	up := to_vector3(state, -3)
	fov := lua.tonumber(state, -2)
	projection := lua.tointeger(state, -1)
	
	lua.pop(state, 5)

	camera.position = position
	camera.target = target
	camera.up = up
	camera.fovy = f32(fov)
	camera.projection = rl.CameraProjection(projection)
    
    return
}

check_camera :: proc "c" (state: ^lua.State, arg: i32) -> rl.Camera3D {
	check_type(state, arg, "Camera3D")
	return to_camera(state, arg)
}