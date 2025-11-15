package YueCat

import lua "vendor:lua/5.4"
import "base:runtime"
import rl "vendor:raylib"
import "core:strings"
import "core:fmt"
import sdl "vendor:sdl2"
import "core:c"
import "core:time"

DrawClear :: proc "c" (state: ^lua.State) -> (results: c.int) {
	context = runtime.default_context()

	color := check_color(state, 1)

	rl.ClearBackground(color)

	return
}

DrawLine :: proc "c" (state: ^lua.State) -> (results: c.int) {
	start := check_vector2(state, 1)
	end := check_vector2(state, 2)
	color := check_color(state, 3)

	rl.DrawLineV(start, end, color)

	return
}

DrawRectangle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	color := check_color(state, 2)

	rl.DrawRectangleRec(rectangle, color)

	return
}

DrawCircle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	circle := check_circle(state, 1)
	color := check_color(state, 2)

	rl.DrawCircleV(circle.position, circle.diameter / 2, color)

	return
}

DrawRectangleLined :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	color := check_color(state, 2)

	rl.DrawRectangleLinesEx(rectangle, 1, color)

	return
}

DrawCircleLined :: proc "c" (state: ^lua.State) -> (results: c.int) {
	circle := check_circle(state, 1)
	color := check_color(state, 2)

	rl.DrawCircleLinesV(circle.position, circle.diameter / 2, color)

	return
}

DrawTriangle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	triangle := check_triangle(state, 1)
	color := check_color(state, 2)

	rl.DrawTriangle(triangle.first_point, triangle.second_point, triangle.third_point, color)

	return
}

DrawTriangleLined :: proc "c" (state: ^lua.State) -> (results: c.int) {
	triangle := check_triangle(state, 1)
	color := check_color(state, 2)

	rl.DrawTriangleLines(triangle.first_point, triangle.second_point, triangle.third_point, color)

	return
}

DrawText :: proc "c" (state: ^lua.State) -> (results: c.int) {
	text := lua.L_checkstring(state, 1)
	position := check_vector2(state, 2)
	color := check_color(state, 3)

	rl.DrawText(text, i32(position.x), i32(position.y), 20, color)

	return
}

GetMouseWheelMove :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetMouseWheelMove()))
	
	return 1
}

GetMouseWheelMoveVector :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetMouseWheelMoveV())

	return 1
}

GetTime :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetTime()))

	return 1
}

GetDelta :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetFrameTime()))

	return 1
}

GetFPS :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetFPS()))

	return 1
}

SetFPSTarget :: proc "c" (state: ^lua.State) -> (results: c.int) {
	target := lua.L_checkinteger(state, 1)

	rl.SetTargetFPS(i32(target))

	return
}

GetMousePosition :: proc "c" (state: ^lua.State) -> (results: c.int) {
	pos := rl.GetMousePosition()

	lua.checkstack(state, 1)
	push_vector2(state, pos)

	return 1
}

GetMouseX :: proc "c" (state: ^lua.State) -> (results: c.int) {
	x := rl.GetMouseX()

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(x))

	return 1
}

GetMouseY :: proc "c" (state: ^lua.State) -> (results: c.int) {
	y := rl.GetMouseY()

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(y))

	return 1
}

SetMouseX :: proc "c" (state: ^lua.State) -> (results: c.int) {
	x := lua.L_checkinteger(state, 1)
	y := rl.GetMouseY()

	rl.SetMousePosition(i32(x), i32(y))

	return
}

SetMouseY :: proc "c" (state: ^lua.State) -> (results: c.int) {
	y := lua.L_checkinteger(state, 1)
	x := rl.GetMouseX()

	rl.SetMousePosition(i32(x), i32(y))

	return
}

SetMousePosition :: proc "c" (state: ^lua.State) -> (results: c.int) {
	pos := check_vector2(state, 1)
	
	rl.SetMousePosition(i32(pos.x), i32(pos.y))

	return
}

IsKeyboardKeyReleased :: proc "c" (state: ^lua.State) -> (results: c.int) {
	idx := lua.L_checkinteger(state, 1)

	b := rl.IsKeyReleased(rl.KeyboardKey(idx))

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(b))

	return 1
}

IsKeyboardKeyPressed :: proc "c" (state: ^lua.State) -> (results: c.int) {
	idx := lua.L_checkinteger(state, 1)

	b := rl.IsKeyPressed(rl.KeyboardKey(idx))

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(b))

	return 1
}

IsKeyboardKeyHeld :: proc "c" (state: ^lua.State) -> (results: c.int) {
	idx := lua.L_checkinteger(state, 1)

	b:= rl.IsKeyDown(rl.KeyboardKey(idx))

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(b))

	return 1
}

IsMouseButtonPressed :: proc "c" (state: ^lua.State) -> (results: c.int) {
	index := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(rl.IsMouseButtonPressed(rl.MouseButton(i32(index)))))

	return 1
}

IsMouseButtonHeld :: proc "c" (state: ^lua.State) -> (results: c.int) {
	index := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(rl.IsMouseButtonDown(rl.MouseButton(i32(index)))))

	return 1
}

IsMouseButtonReleased :: proc "c" (state: ^lua.State) -> (results: c.int) {
	index := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(rl.IsMouseButtonReleased(rl.MouseButton(i32(index)))))

	return 1
}

DrawTexture :: proc "c" (state: ^lua.State) -> (results: c.int) {
	texture: rl.Texture

	if is_type(state, 1, "RenderTexture") {
		texture = check_rendertexture(state, 1).texture
	} else {
		texture = check_texture(state, 1)^
	}

	position := check_vector2_default(state, 2, {})
	tint := check_color_default(state, 3, rl.WHITE)

	rl.DrawTextureV(texture, position, tint)

	return
}

PlayAudio :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	if config.audio_active {
		audio := check_audio(state, 1)

		rl.PlaySound(audio^)
	}

	return
}

StringStartsWith :: proc "c" (state: ^lua.State) -> (results: c.int) {
	context = runtime.default_context()

	str := lua.L_checkstring(state, 1)
	sub := lua.L_checkstring(state, 2)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(strings.starts_with(string(str), string(sub))))

	return 1
}

StringEndsWith :: proc "c" (state: ^lua.State) -> (results: c.int) {
	context = runtime.default_context()

	str := lua.L_checkstring(state, 1)
	sub := lua.L_checkstring(state, 2)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(strings.ends_with(string(str), string(sub))))

	return 1
}

OpenURL :: proc "c" (state: ^lua.State) -> (results: c.int) {
	url := lua.L_checkstring(state, 1)

	rl.OpenURL(url)

	return
}

ColorFromHSV :: proc "c" (state: ^lua.State) -> (results: c.int) {
	hsv := check_color_hsv(state, 1)

	color := rl.ColorFromHSV(hsv.h, hsv.s, hsv.v)
	color.a = hsv.a

	lua.checkstack(state, 1)
	push_color(state, color)

	return 1
}

ColorToHSV :: proc "c" (state: ^lua.State) -> (results: c.int) {
	color := check_color(state, 1)

	RLhsv := rl.ColorToHSV(color)

	lua.checkstack(state, 1)
	push_color_hsv(state, {RLhsv[0], RLhsv[1], RLhsv[2], 1})

	return 1
}

Begin3D :: proc "c" (state: ^lua.State) -> (results: c.int) {
	camera := check_camera(state, 1)

	rl.BeginMode3D(camera)

	return
}

End3D :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.EndMode3D()

	return
}

DrawGrid :: proc "c" (state: ^lua.State) -> (results: c.int) {
	slices := lua.L_checkinteger(state, 1)
	spacing := lua.L_checknumber(state, 2)

	rl.DrawGrid(i32(slices), f32(spacing))

	return
}

DrawCube :: proc "c" (state: ^lua.State) -> (results: c.int) {
	position := check_vector3(state, 1)
	size := lua.L_checknumber(state, 2)
	color := check_color(state, 3)

	rl.DrawCube(position, f32(size), f32(size), f32(size), color)

	return
}

DrawBox :: proc "c" (state: ^lua.State) -> (results: c.int) {
	position := check_vector3(state, 1)
	size := check_vector3(state, 2)
	color := check_color(state, 3)

	rl.DrawCubeV(position, size, color)

	return
}

check_controller :: proc "c" (state: ^lua.State, arg: i32) -> ^Controller {
	check_type(state, arg, "Controller")
	
	lua.checkstack(state, 1)
	lua.getfield(state, arg, "index")
	
	index := uint(lua.tointeger(state, -1))

	if index in controllers {
		return &controllers[index]
	}

	lua.pop(state, 1)

	return {}
}

IsCursorOnScreen :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(rl.IsCursorOnScreen()))

	return 1
}

IsControllerButtonHeld :: proc "c" (state: ^lua.State) -> (results: c.int) {
	controller := check_controller(state, 1)
	button := lua.L_checkinteger(state, 2)
	
	lua.checkstack(state, 1)

	output: bool 

	if controller.valid {
		output = bool(sdl.GameControllerGetButton(controller.sdl_pointer, sdl.GameControllerButton(button)))
	}

	lua.pushboolean(state, b32(output))

	return 1
}

IsControllerButtonPressed :: proc "c" (state: ^lua.State) -> (results: c.int) {
	context = runtime.default_context()

	controller := check_controller(state, 1)
	button := lua.L_checkinteger(state, 2)

	lua.checkstack(state, 1)

	output: bool

	if controller.valid {
		output = sdl.GameControllerButton(button) in controller.pressed
	}

	lua.pushboolean(state, b32(output))

	return 1
}

IsControllerButtonReleased :: proc "c" (state: ^lua.State) -> (results: c.int) {
	context = runtime.default_context()

	controller := check_controller(state, 1)
	button := lua.L_checkinteger(state, 2)

	lua.checkstack(state, 1)

	output: bool

	if controller.valid {
		output = sdl.GameControllerButton(button) in controller.released
	}

	lua.pushboolean(state, b32(output))

	return 1
}

GetAxis :: proc "c" (controller: ^Controller, axis: sdl.GameControllerAxis) -> (axis_value: f32) {
	if controller.valid {
		axis_value_raw := sdl.GameControllerGetAxis(controller.sdl_pointer, sdl.GameControllerAxis(axis))

		axis_value = f32(axis_value_raw) / f32(max(i16))
		axis_value = clamp(axis_value, -1, 1)

		if abs(axis_value) <= controller.deadzone {
			axis_value = 0
		}
	}

	return
}

GetControllerAxis :: proc "c" (state: ^lua.State) -> (results: c.int) {
	controller := check_controller(state, 1)
	axis := lua.L_checkinteger(state, 2)

	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(GetAxis(controller, sdl.GameControllerAxis(axis))))

	return 1
}

GetControllerVector :: proc "c" (state: ^lua.State) -> (results: c.int) {
	controller := check_controller(state, 1)
	vector_index := lua.L_checkinteger(state, 2)

	vector: rl.Vector2

	if controller.valid {
		pointer := controller.sdl_pointer

		switch vector_index {
			case 0:
				if bool(sdl.GameControllerGetButton(pointer, .DPAD_LEFT)) {
					vector.x -= 1
				}
	
				if bool(sdl.GameControllerGetButton(pointer, .DPAD_RIGHT)) {
					vector.x += 1
				}
	
				if bool(sdl.GameControllerGetButton(pointer, .DPAD_UP)) {
					vector.y -= 1
				}
	
				if bool(sdl.GameControllerGetButton(pointer, .DPAD_DOWN)) {
					vector.y += 1
				}
	
				vector = rl.Vector2Normalize(vector) // Ta-Da!
			case 1:
				vector.x = GetAxis(controller, .LEFTX)
				vector.y = GetAxis(controller, .LEFTY)
			case 2:
				vector.x = GetAxis(controller, .RIGHTX)
				vector.y = GetAxis(controller, .RIGHTY)
		}
	}

	lua.checkstack(state, 1)
	push_vector2(state, vector)

	return 1
}

GetControllerName :: proc "c" (state: ^lua.State) -> (results: c.int) {
	controller := check_controller(state, 1)

	lua.checkstack(state, 1)

	str: cstring = ""

	if controller.valid {
		str = sdl.GameControllerName(controller.sdl_pointer)
	}

	lua.pushstring(state, str)

	return 1
}

DrawFPS :: proc "c" (state: ^lua.State) -> (results: c.int) {
	position := check_vector2_default(state, 1, {5, 5})

	rl.DrawFPS(c.int(position.x), c.int(position.y))

	return
}

ControllerSetDeadzone :: proc "c" (state: ^lua.State) -> (results: c.int) {
	controller := check_controller(state, 1)

	controller.deadzone = f32(lua.L_checknumber(state, 2))

	return
}

ControllerGetDeadzone :: proc "c" (state: ^lua.State) -> (results: c.int) {
	controller := check_controller(state, 1)

	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(controller.deadzone))

	return 1
}

ControllerSetDefaultDeadzone :: proc "c" (state: ^lua.State) -> (results: c.int) {
	config.default_deadzone = f32(lua.L_checknumber(state, 1))

	return
}

ControllerGetDefaultDeadzone :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(config.default_deadzone))

	return 1
}

BeginScissor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	rl.BeginScissorMode(i32(rectangle.x), i32(rectangle.y), i32(rectangle.width), i32(rectangle.height))

	return
}

EndScissor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.EndScissorMode()

	return
}

MinimizeWindow :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.MinimizeWindow()

	return
}

MaximizeWindow :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.MaximizeWindow()

	return
}

RestoreWindow :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.RestoreWindow()

	return
}

SetWindowPosition :: proc "c" (state: ^lua.State) -> (results: c.int) {
	position := check_vector2(state, 1)

	rl.SetWindowPosition(c.int(position.x), c.int(position.y))

	return
}

SetWindowTitle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	title := lua.L_checkstring(state, 1)

	rl.SetWindowTitle(title)

	return
}

SetWindowMonitor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)

	rl.SetWindowMonitor(c.int(monitor))

	return
}

SetWindowSizeMinimum :: proc "c" (state: ^lua.State) -> (results: c.int) {
	minimum := check_vector2(state, 1)

	rl.SetWindowMinSize(c.int(minimum.x), c.int(minimum.y))

	return
}

SetWindowSizeMaximum :: proc "c" (state: ^lua.State) -> (results: c.int) {
	maximum := check_vector2(state, 1)

	rl.SetWindowMaxSize(c.int(maximum.x), c.int(maximum.y))

	return
}

SetWindowSize :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)

	rl.SetWindowSize(c.int(size.x), c.int(size.y))

	return
}

GetWindowSize :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := rl.Vector2 {f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight())}

	lua.checkstack(state, 1)
	push_vector2(state, size)

	return 1
}

GetWindowWidth :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetScreenWidth()))

	return 1
}

GetWindowHeight :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetScreenHeight()))

	return 1
}

SetWindowOpacity :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.SetWindowOpacity(c.float(lua.L_checknumber(state, 1)))

	return
}

GetCurrentMonitor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetCurrentMonitor()))

	return 1
}

GetWindowPosition :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetWindowPosition())

	return 1
}

GetMonitorCount :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetMonitorCount()))

	return 1
}

GetClipboard :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushstring(state, rl.GetClipboardText())

	return 1
}

SetClipboard :: proc "c" (state: ^lua.State) -> (results: c.int) {
	clipboard_text := rl.GetClipboardText()

	rl.SetClipboardText(clipboard_text)

	return
}

ShowCursor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.ShowCursor()

	return
}

HideCursor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.HideCursor()

	return
}

SetMasterVolume :: proc "c" (state: ^lua.State) -> (results: c.int) {
	volume := lua.L_checknumber(state, 1)
	
	rl.SetMasterVolume(c.float(volume))

	return
}

GetMasterVolume :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetMasterVolume()))

	return 1
}

TextureGetSize :: proc "c" (state: ^lua.State) -> (results: c.int) {
	texture := check_texture(state, 1)

	vector := rl.Vector2 {f32(texture.width), f32(texture.height)}
	lua.checkstack(state, 1)
	push_vector2(state, vector)
	
	return 1
}

TextureGetWidth :: proc "c" (state: ^lua.State) -> (results: c.int) {
	texture := check_texture(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(texture.width))
	
	return 1
}

TextureGetHeight :: proc "c" (state: ^lua.State) -> (results: c.int) {
	texture := check_texture(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(texture.height))

	return 1
}

AudioGetChannelCount :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(audio.channels))

	return 1
}

AudioGetFrameCount :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(audio.frameCount))

	return 1
}

AudioGetSampleRate :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(audio.sampleRate))

	return 1
}

AudioGetSampleSize :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(audio.sampleSize))

	return 1
}

check_number_default :: proc "c" (state: ^lua.State, arg: c.int, default: c.float = 0) -> (result: c.float) {
	if lua.isnumber(state, arg) {
		result = c.float(lua.tonumber(state, arg))
	} else if lua.isnoneornil(state, arg) {
		result = default
	} else {
		// TODO: Maybe improve with check_type
		lua.L_checknumber(state, arg)
	}

	return
}

check_integer_default :: proc "c" (state: ^lua.State, arg: c.int, default: c.int = 0) -> (result: c.int) {
	if lua.isinteger(state, arg) {
		result = c.int(lua.tointeger(state, arg))
	} else if lua.isnoneornil(state, arg) {
		result = default
	} else {
		lua.L_checkinteger(state, 1)
	}

	return
}

GetTouchX :: proc "c" (state: ^lua.State) -> (results: c.int) {
	touch_index := check_integer_default(state, 1)

	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetTouchPosition(touch_index).x))

	return 1
}

GetTouchY :: proc "c" (state: ^lua.State) -> (results: c.int) {
	touch_index := check_integer_default(state, 1)

	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetTouchPosition(touch_index).y))

	return 1
}

GetTouchPosition :: proc "c" (state: ^lua.State) -> (results: c.int) {
	touch_index := check_integer_default(state, 1)

	lua.checkstack(state, 1)
	push_vector2(state, rl.GetTouchPosition(touch_index))

	return 1
}

GetTouchPointId :: proc "c" (state: ^lua.State) -> (results: c.int) {
	touch_index := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetTouchPointId(c.int(touch_index))))

	return 1
}

GetTouchPointCount :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetTouchPointCount()))

	return 1
}

IsCursorHidden :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(rl.IsCursorHidden()))

	return 1
}

SetExitKey :: proc "c" (state: ^lua.State) -> (results: c.int) {
	if lua.isnoneornil(state, 1) {
		rl.SetExitKey(.KEY_NULL)
	} else {
		key := lua.L_checkinteger(state, 1)
	
		rl.SetExitKey(rl.KeyboardKey(key))
	}

	return 0
}

GetMouseDelta :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetMouseDelta())

	return 1
}

Sleep :: proc "c" (state: ^lua.State) -> (results: c.int) {
	time := lua.L_checknumber(state, 1)

	rl.WaitTime(f64(time))

	return
}

TakeScreenshot :: proc "c" (state: ^lua.State) -> (results: c.int) {
	filename := lua.L_checkstring(state, 1)

	rl.TakeScreenshot(filename)

	return
}

Now :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_time(state, time.now())

	return 1
}

Weekday :: proc "c" (state: ^lua.State) -> (results: c.int) {
	pushed_time := check_time(state, 1)
	
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(time.weekday(pushed_time)))

	return 1
}

Year :: proc "c" (state: ^lua.State) -> (results: c.int) {
	pushed_time := check_time(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(time.year(pushed_time)))

	return 1
}

Month :: proc "c" (state: ^lua.State) -> (results: c.int) {
	pushed_time := check_time(state, 1)
	
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(time.month(pushed_time)))

	return 1
}

IsLeapYear :: proc "c" (state: ^lua.State) -> (results: c.int) {
	year := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(time.is_leap_year(int(year))))

	return 1
}

FromNanoseconds :: proc "c" (state: ^lua.State) -> (results: c.int) {
	pushed_time := time.from_nanoseconds(i64(lua.L_checkinteger(state, 1)))

	lua.checkstack(state, 1)
	push_time(state, pushed_time)

	return 1
}

Day :: proc "c" (state: ^lua.State) -> (results: c.int) {
	day := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(time.day({i64(day)})))

	return 1
}

DrawRectangleGradientV :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	top_color := check_color(state, 2)
	bottom_color := check_color(state, 3)

	rl.DrawRectangleGradientEx(rectangle, top_color, bottom_color, top_color, bottom_color)

	return
}

DrawRectangleGradientH :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	left_color := check_color(state, 2)
	right_color := check_color(state, 3)

	rl.DrawRectangleGradientEx(rectangle, left_color, left_color, right_color, right_color)

	return
}

DrawRectangleGradient :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	top_left_color := check_color(state, 2)
	top_right_color := check_color(state, 3)
	bottom_left_color := check_color(state, 4)
	bottom_right_color := check_color(state, 5)
	
	rl.DrawRectangleGradientEx(rectangle, top_left_color, bottom_left_color, top_right_color, bottom_right_color)

	return
}

DrawRectangleRounded :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	roundness := lua.L_checknumber(state, 2)
	segments := lua.L_checkinteger(state, 3)
	color := check_color(state, 4)

	rl.DrawRectangleRounded(rectangle, c.float(roundness), c.int(segments), color)

	return
}

DrawRectangleRoundedLined :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rectangle := check_rectangle(state, 1)
	roundness := lua.L_checknumber(state, 2)
	segments := lua.L_checkinteger(state, 3)
	color := check_color(state, 4)

	rl.DrawRectangleRoundedLines(rectangle, c.float(roundness), c.int(segments), color)

	return
}

GetMonitorPosition :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)
	
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetMonitorPosition(c.int(monitor)))

	return 1
}

GetMonitorWidth :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetMonitorWidth(c.int(monitor))))

	return 1
}

GetMonitorHeight :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetMonitorHeight(c.int(monitor))))

	return 1
}

GetMonitorSize :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	push_vector2(state, {c.float(rl.GetMonitorWidth(c.int(monitor))), c.float(rl.GetMonitorHeight(c.int(monitor)))})

	return 1
}

GetMonitorPhysicalWidth :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetMonitorPhysicalWidth(c.int(monitor))))

	return 1
}

GetMonitorPhysicalHeight :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)
	
	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetMonitorPhysicalHeight(c.int(monitor))))

	return 1
}

GetMonitorPhysicalSize :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)
	c_monitor := c.int(monitor)

	lua.checkstack(state, 1)
	push_vector2(state, {c.float(rl.GetMonitorPhysicalWidth(c_monitor)), c.float(rl.GetMonitorPhysicalHeight(c_monitor))})

	return 1
}

GetMonitorRefreshRate :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)
	c_monitor := c.int(monitor)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(rl.GetMonitorRefreshRate(c_monitor)))

	return 1
}

GetMonitorName :: proc "c" (state: ^lua.State) -> (results: c.int) {
	monitor := lua.L_checkinteger(state, 1)
	c_monitor := c.int(monitor)
	
	lua.checkstack(state, 1)
	lua.pushstring(state, rl.GetMonitorName(c_monitor))

	return 1
}

AudioSetVolume :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)
	volume := lua.L_checknumber(state, 2)

	rl.SetSoundVolume(audio^, c.float(volume))

	return
}

AudioSetPitch :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)
	pitch := lua.L_checknumber(state, 2)
	
	rl.SetSoundPitch(audio^, c.float(pitch))

	return
}

AudioSetPan :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)
	pan := lua.L_checknumber(state, 2)

	rl.SetSoundPan(audio^, c.float(pan))

	return
}

StopAudio :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	rl.StopSound(audio^)

	return
}

PauseAudio :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	rl.PauseSound(audio^)

	return
}

ResumeAudio :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	rl.ResumeSound(audio^)

	return
}

IsAudioPlaying :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio_warning()

	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(rl.IsSoundPlaying(audio^)))

	return 1
}

PlayMusicStream :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)

	rl.PlayMusicStream(music^)
	
	return
}

IsMusicStreamPlaying :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)

	lua.checkstack(state, 1)
	lua.pushboolean(state, b32(rl.IsMusicStreamPlaying(music^)))

	return 1
}

StopMusicStream :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)

	rl.StopMusicStream(music^)

	return
}

PauseMusicStream :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)

	rl.PauseMusicStream(music^)

	return
}

ResumeMusicStream :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)

	rl.ResumeMusicStream(music^)

	return
}

SeekMusicStream :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)
	seconds := lua.L_checknumber(state, 2)

	rl.SeekMusicStream(music^, c.float(seconds))

	return
}

SetMusicVolume :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)
	volume := lua.L_checknumber(state, 2)

	rl.SetMusicVolume(music^, c.float(volume))

	return
}

SetMusicPitch :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)
	pitch := lua.L_checknumber(state, 2)

	rl.SetMusicPitch(music^, c.float(pitch))

	return
}

SetMusicPan :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)
	pan := lua.L_checknumber(state, 2)

	rl.SetMusicPan(music^, c.float(pan))

	return
}

GetMusicTimeLength :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)

	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetMusicTimeLength(music^)))

	return 1
}

GetMusicStreamTimePlayed :: proc "c" (state: ^lua.State) -> (results: c.int) {
	music := check_music(state, 1)
	
	lua.checkstack(state, 1)
	lua.pushnumber(state, lua.Number(rl.GetMusicTimePlayed(music^)))

	return 1
}

EndTextureMode :: proc "c" (state: ^lua.State) -> (results: c.int) {
	rl.EndTextureMode()

	return
}

BeginTextureMode :: proc "c" (state: ^lua.State) -> (results: c.int) {
	tex := check_rendertexture(state, 1)

	rl.BeginTextureMode(tex^)

	return
}

SetTextureFilter :: proc "c" (state: ^lua.State) -> (results: c.int) {
	texture := check_texture(state, 1)
	filter := lua.L_checkinteger(state, 2)

	rl.SetTextureFilter(texture^, rl.TextureFilter(filter))

	return
}

SetTextureWrap :: proc "c" (state: ^lua.State) -> (results: c.int) {
	texture := check_texture(state, 1)
	wrap := lua.L_checkinteger(state, 2)

	rl.SetTextureWrap(texture^, rl.TextureWrap(wrap))

	return
}

DrawPixel :: proc "c" (state: ^lua.State) -> (results: c.int) {
	position := check_vector2(state, 1)
	color := check_color(state, 2)

	rl.DrawPixelV(position, color)

	return
}

GetSplinePointLinear :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetSplinePointLinear(check_vector2(state, 1), check_vector2(state, 2), f32(lua.L_checknumber(state, 3))))

	return 1
}

GetSplinePointBasis :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetSplinePointBasis(check_vector2(state, 1), check_vector2(state, 2), check_vector2(state, 3), check_vector2(state, 4), f32(lua.L_checknumber(state, 5))))

	return 1
}

GetSplinePointCatmullRom :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetSplinePointCatmullRom(check_vector2(state, 1), check_vector2(state, 2), check_vector2(state, 3), check_vector2(state, 4), f32(lua.L_checknumber(state, 5))))
	
	return 1
}

GetSplinePointBezierQuad :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetSplinePointBezierQuad(check_vector2(state, 1), check_vector2(state, 2), check_vector2(state, 3), f32(lua.L_checknumber(state, 4))))

	return 1
}

GetSplinePointBezierCubic :: proc "c" (state: ^lua.State) -> (results: c.int) {
	lua.checkstack(state, 1)
	push_vector2(state, rl.GetSplinePointBezierCubic(check_vector2(state, 1), check_vector2(state, 2), check_vector2(state, 3), check_vector2(state, 4), f32(lua.L_checknumber(state, 4))))

	return 1
}

GenerateImageColor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	color := check_color(state, 2)

	img := rl.GenImageColor(c.int(size.x), c.int(size.y), color)

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImageGradientLinear :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	direction := lua.L_checknumber(state, 2)
	start_color := check_color(state, 3)
	end_color := check_color(state, 4)

	img := rl.GenImageGradientLinear(c.int(size.x), c.int(size.y), c.int(direction), start_color, end_color)

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImageGradientRadial :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	density := lua.L_checknumber(state, 2)
	inner_color := check_color(state, 3)
	outer_color := check_color(state, 4)

	img := rl.GenImageGradientRadial(c.int(size.x), c.int(size.y), f32(density), inner_color, outer_color)

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImageGradientSquare :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	density := lua.L_checknumber(state, 2)
	inner_color := check_color(state, 3)
	outer_color := check_color(state, 4)

	img := rl.GenImageGradientSquare(c.int(size.x), c.int(size.y), f32(density), inner_color, outer_color)
	
	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImageCheckered :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	checker_size := check_vector2(state, 2)
	color1 := check_color(state, 3)
	color2 := check_color(state, 4)

	img := rl.GenImageChecked(c.int(size.x), c.int(size.y), c.int(checker_size.x), c.int(checker_size.y), color1, color2)

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImageWhiteNoise :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	factor := lua.L_checknumber(state, 2)

	img := rl.GenImageWhiteNoise(c.int(size.x), c.int(size.y), f32(factor))

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImagePerlinNoise :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	offset := check_vector2(state, 2)
	factor := lua.L_checknumber(state, 3)

	img := rl.GenImagePerlinNoise(c.int(size.x), c.int(size.y), c.int(offset.x), c.int(offset.y), f32(factor))

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImageCellular :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	tile_size := lua.L_checkinteger(state, 2)

	img := rl.GenImageCellular(c.int(size.x), c.int(size.y), c.int(tile_size))

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

GenerateImageText :: proc "c" (state: ^lua.State) -> (results: c.int) {
	size := check_vector2(state, 1)
	text := lua.L_checkstring(state, 2)

	img := rl.GenImageText(c.int(size.x), c.int(size.y), text)

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

ImageCopy :: proc "c" (state: ^lua.State) -> (results: c.int) {
	img := check_image(state, 1)
	
	img_copy := rl.ImageCopy(img^)

	lua.checkstack(state, 1)
	push_image(state, &img_copy)

	return 1
}

ImageFromRectangle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	img := check_image(state, 1)
	rectangle := check_rectangle(state, 2)

	img_rectangle := rl.ImageFromImage(img^, rectangle)

	lua.checkstack(state, 1)
	push_image(state, &img_rectangle)

	return 1
}

ImageFromChannel :: proc "c" (state: ^lua.State) -> (results: c.int) {
	img := check_image(state, 1)
	channel := check_integer_default(state, 2, 0)

	img_channel := rl.ImageFromChannel(img^, channel)

	lua.checkstack(state, 1)
	push_image(state, &img_channel)

	return 1
}

ImageText :: proc "c" (state: ^lua.State) -> (results: c.int) {
	text := lua.L_checkstring(state, 1)
	font_size := check_integer_default(state, 2, rl.GetFontDefault().baseSize)
	color := check_color(state, 3)

	img := rl.ImageText(text, font_size, color)

	lua.checkstack(state, 1)
	push_image(state, &img)

	return 1
}

ImageCrop :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	crop := check_rectangle(state, 2)

	rl.ImageCrop(image, crop)

	return
}

ImageAlphaCrop :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	threshold := lua.L_checknumber(state, 2)
	
	rl.ImageAlphaCrop(image, f32(threshold))

	return
}

ImageAlphaClear :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	color := check_color(state, 2)
	threshold := lua.L_checknumber(state, 3)

	rl.ImageAlphaClear(image, color, f32(threshold))

	return
}

ImageAlphaMask :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	image_alpha_mask := check_image(state, 2)
	
	rl.ImageAlphaMask(image, image_alpha_mask^)

	return
}

ImageAlphaPremultiply :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)

	rl.ImageAlphaPremultiply(image)

	return
}

ImageBlurGaussian :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	size := lua.L_checkinteger(state, 2)

	rl.ImageBlurGaussian(image, c.int(size))

	return
}

ImageResizeBilinear :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	size := check_vector2(state, 2)

	rl.ImageResize(image, c.int(size.x), c.int(size.y))

	return
}

ImageResizeNN :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	size := check_vector2(state, 2)

	rl.ImageResizeNN(image, c.int(size.x), c.int(size.y))

	return
}

ImageMipmaps :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	
	rl.ImageMipmaps(image)

	return
}

ImageDither :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	r_bpp := lua.L_checkinteger(state, 2)
	g_bpp := lua.L_checkinteger(state, 3)
	b_bpp := lua.L_checkinteger(state, 4)
	a_bpp := check_integer_default(state, 5, 255)

	rl.ImageDither(image, c.int(r_bpp), c.int(g_bpp), c.int(b_bpp), a_bpp)

	return
}

ImageFlipVertical :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)

	rl.ImageFlipVertical(image)

	return
}

ImageFlipHorizontal :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)

	rl.ImageFlipHorizontal(image)

	return
}

ImageRotate :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	degrees := lua.L_checknumber(state, 2)

	rl.ImageRotate(image, c.int(degrees))

	return
}

ImageRotateCW :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)

	rl.ImageRotateCW(image)

	return
}

ImageRotateCCW :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)

	rl.ImageRotateCCW(image)

	return
}

ImageColorTint :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	color := check_color(state, 2)

	rl.ImageColorTint(image, color)

	return
}

ImageColorInvert :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	
	rl.ImageColorInvert(image)

	return
}

ImageColorGrayscale :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)

	rl.ImageColorGrayscale(image)

	return
}

ImageColorContrast :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	contrast := lua.L_checknumber(state, 2)

	rl.ImageColorContrast(image, f32(contrast))

	return
}

ImageColorBrightness :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	brightness := lua.L_checkinteger(state, 2)

	rl.ImageColorBrightness(image, c.int(brightness))

	return
}

ImageColorReplace :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	color_to_replace := check_color(state, 2)
	replacement_color := check_color(state, 3)
	
	rl.ImageColorReplace(image, color_to_replace, replacement_color)

	return
}

GetImageColor :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	position := check_vector2(state, 2)

	color := rl.GetImageColor(image^, c.int(position.x), c.int(position.y))

	lua.checkstack(state, 1)
	push_color(state, color)

	return 1
}

ImageDrawLine :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	start_position := check_vector2(state, 2)
	end_position := check_vector2(state, 3)
	color := check_color(state, 4)

	rl.ImageDrawLineV(image, start_position, end_position, color)

	return
}

ImageDrawCircle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	circle := check_circle(state, 2)
	color := check_color(state, 3)

	rl.ImageDrawCircleV(image, circle.position, c.int(circle.diameter / 2), color)

	return
}

ImageDrawCircleLined :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	circle := check_circle(state, 1)
	color := check_color(state, 3)

	rl.ImageDrawCircleLinesV(image, circle.position, c.int(circle.diameter / 2), color)

	return
}

ImageDrawRectangle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	rectangle := check_rectangle(state, 2)
	color := check_color(state, 3)

	rl.ImageDrawRectangleRec(image, rectangle, color)

	return
}

ImageDrawRectangleLined :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	rectangle := check_rectangle(state, 2)
	color := check_color(state, 3)

	rl.ImageDrawRectangleLines(image, rectangle, 1, color)

	return
}

ImageDrawText :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	text := lua.L_checkstring(state, 2)
	position := check_vector2(state, 3)
	font_size := check_integer_default(state, 4, rl.GetFontDefault().baseSize)
	color := check_color(state, 5)
	
	rl.ImageDrawText(image, text, c.int(position.x), c.int(position.y), font_size, color)

	return
}

ImageDrawTextEx :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	font := check_font(state, 2)
	text := lua.L_checkstring(state, 3)
	position := check_vector2(state, 4)
	font_size := check_number_default(state, 5, f32(font.baseSize))
	spacing := check_number_default(state, 6, f32(font.glyphPadding))
	color := check_color(state, 7)

	rl.ImageDrawTextEx(image, font^, text, position, font_size, spacing, color)

	return
}

ImageDrawTriangle :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	triangle := check_triangle(state, 2)
	color := check_color(state, 3)

	rl.ImageDrawTriangle(image, triangle.first_point, triangle.second_point, triangle.third_point, color)

	return
}

ImageDrawTriangleLined :: proc "c" (state: ^lua.State) -> (results: c.int) {
	image := check_image(state, 1)
	triangle := check_triangle(state, 2)
	color := check_color(state, 3)
	
	rl.ImageDrawTriangleLines(image, triangle.first_point, triangle.second_point, triangle.third_point, color)

	return
}