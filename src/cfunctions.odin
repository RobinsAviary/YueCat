package YueCat

import lua "vendor:lua/5.4"
import "base:runtime"
import rl "vendor:raylib"
import "core:strings"
import "core:fmt"
import sdl "vendor:sdl2"
import "core:c"

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
	texture := check_texture(state, 1)
	position := check_vector2_default(state, 2, {})
	tint := check_color_default(state, 3, rl.WHITE)

	rl.DrawTextureV(texture^, position, tint)

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

	push_color(state, color)

	return 1
}

ColorToHSV :: proc "c" (state: ^lua.State) -> (results: c.int) {
	color := check_color(state, 1)

	RLhsv := rl.ColorToHSV(color)

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

	lua.checkstack(state, 1)
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
	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(audio.channels))

	return 1
}

AudioGetFrameCount :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(audio.frameCount))

	return 1
}

AudioGetSampleRate :: proc "c" (state: ^lua.State) -> (results: c.int) {
	audio := check_audio(state, 1)

	lua.checkstack(state, 1)
	lua.pushinteger(state, lua.Integer(audio.sampleRate))

	return 1
}

AudioGetSampleSize :: proc "c" (state: ^lua.State) -> (results: c.int) {
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

