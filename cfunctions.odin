package LuaCat

import lua "vendor:lua/5.4"
import "base:runtime"
import rl "vendor:raylib"
import "core:strings"

DrawClear :: proc "c" (state: ^lua.State) -> i32 {
	context = runtime.default_context()

	color := check_color(state, 1)

	rl.ClearBackground(color)

	return 0
}

DrawLine :: proc "c" (state: ^lua.State) -> i32 {
	start := check_vector2(state, 1)
	end := check_vector2(state, 2)
	color := check_color(state, 3)

	rl.DrawLineV(start, end, color)

	return 0
}

DrawRectangle :: proc "c" (state: ^lua.State) -> i32 {
	rectangle := check_rectangle(state, 1)
	color := check_color(state, 2)

	rl.DrawRectangleRec(rectangle, color)

	return 0
}

DrawCircle :: proc "c" (state: ^lua.State) -> i32 {
	circle := check_circle(state, 1)
	color := check_color(state, 2)

	rl.DrawCircleV(circle.position, circle.diameter / 2, color)

	return 0
}

DrawRectangleLined :: proc "c" (state: ^lua.State) -> i32 {
	rectangle := check_rectangle(state, 1)
	color := check_color(state, 2)

	rl.DrawRectangleLinesEx(rectangle, 1, color)

	return 0
}

DrawCircleLined :: proc "c" (state: ^lua.State) -> i32 {
    circle := check_circle(state, 1)
    color := check_color(state, 2)

    rl.DrawCircleLinesV(circle.position, circle.diameter / 2, color)

	return 0
}

DrawTriangle :: proc "c" (state: ^lua.State) -> i32 {
    triangle := check_triangle(state, 1)
    color := check_color(state, 2)

    rl.DrawTriangle(triangle.first_point, triangle.second_point, triangle.third_point, color)

    return 0
}

DrawTriangleLined :: proc "c" (state: ^lua.State) -> i32 {
    triangle := check_triangle(state, 1)
    color := check_color(state, 2)

    rl.DrawTriangleLines(triangle.first_point, triangle.second_point, triangle.third_point, color)

    return 0
}

DrawText :: proc "c" (state: ^lua.State) -> i32 {
	text := lua.L_checkstring(state, 1)
	position := check_vector2(state, 2)
	color := check_color(state, 3)

	rl.DrawText(text, i32(position.x), i32(position.y), 20, color)

	return 0
}

GetMouseWheelMove :: proc "c" (state: ^lua.State) -> i32 {
    lua.pushnumber(state, lua.Number(rl.GetMouseWheelMoveV().y))
    
    return 1
}

GetTime :: proc "c" (state: ^lua.State) -> i32 {
	lua.pushnumber(state, lua.Number(rl.GetTime()))

	return 1
}

GetDelta :: proc "c" (state: ^lua.State) -> i32 {
	lua.pushnumber(state, lua.Number(rl.GetFrameTime()))

	return 1
}

GetFPS :: proc "c" (state: ^lua.State) -> i32 {
	lua.pushinteger(state, lua.Integer(rl.GetFPS()))

	return 1
}

SetFPSTarget :: proc "c" (state: ^lua.State) -> i32 {
	target := lua.L_checkinteger(state, 1)

	rl.SetTargetFPS(i32(target))

	return 0
}

GetMousePosition :: proc "c" (state: ^lua.State) -> i32 {
	pos := rl.GetMousePosition()

	push_vector2(state, pos)

	return 1
}

GetMouseX :: proc "c" (state: ^lua.State) -> i32 {
	x := rl.GetMouseX()

	lua.pushinteger(state, lua.Integer(x))

	return 1
}

GetMouseY :: proc "c" (state: ^lua.State) -> i32 {
	y := rl.GetMouseY()

	lua.pushinteger(state, lua.Integer(y))

	return 1
}

SetMouseX :: proc "c" (state: ^lua.State) -> i32 {
	x := lua.L_checkinteger(state, 1)
	y := rl.GetMouseY()

	rl.SetMousePosition(i32(x), i32(y))

	return 0
}

SetMouseY :: proc "c" (state: ^lua.State) -> i32 {
	y := lua.L_checkinteger(state, 1)
	x := rl.GetMouseX()

	rl.SetMousePosition(i32(x), i32(y))

	return 0
}

SetMousePosition :: proc "c" (state: ^lua.State) -> i32 {
	pos := check_vector2(state, 1)
	
	rl.SetMousePosition(i32(pos.x), i32(pos.y))

	return 0
}

IsKeyboardKeyReleased :: proc "c" (state: ^lua.State) -> i32 {
	idx := lua.L_checkinteger(state, 1)

	b := rl.IsKeyReleased(rl.KeyboardKey(idx))

	lua.pushboolean(state, b32(b))

	return 1
}

IsKeyboardKeyPressed :: proc "c" (state: ^lua.State) -> i32 {
	idx := lua.L_checkinteger(state, 1)

	b := rl.IsKeyPressed(rl.KeyboardKey(idx))

	lua.pushboolean(state, b32(b))

	return 1
}

IsKeyboardKeyHeld :: proc "c" (state: ^lua.State) -> i32 {
	idx := lua.L_checkinteger(state, 1)

	b:= rl.IsKeyDown(rl.KeyboardKey(idx))

	lua.pushboolean(state, b32(b))

	return 1
}

IsMouseButtonPressed :: proc "c" (state: ^lua.State) -> i32 {
	index := lua.L_checkinteger(state, 1)

	lua.pushboolean(state, b32(rl.IsMouseButtonPressed(rl.MouseButton(i32(index)))))

	return 1
}

IsMouseButtonHeld :: proc "c" (state: ^lua.State) -> i32 {
	index := lua.L_checkinteger(state, 1)

	lua.pushboolean(state, b32(rl.IsMouseButtonDown(rl.MouseButton(i32(index)))))

	return 1
}

IsMouseButtonReleased :: proc "c" (state: ^lua.State) -> i32 {
	index := lua.L_checkinteger(state, 1)

	lua.pushboolean(state, b32(rl.IsMouseButtonReleased(rl.MouseButton(i32(index)))))

	return 1
}

DrawTexture :: proc "c" (state: ^lua.State) -> i32 {
    texture := check_texture(state, 1)
	position := check_vector2_default(state, 2, {})
	tint := check_color_default(state, 3, rl.WHITE)

	rl.DrawTextureV(texture^, position, tint)

	return 0
}

PlayAudio :: proc "c" (state: ^lua.State) -> i32 {
	audio_warning()

	if config.audio_active {
		audio := check_audio(state, 1)

		rl.PlaySound(audio^)
	}

	return 0
}

StringStartsWith :: proc "c" (state: ^lua.State) -> i32 {
	context = runtime.default_context()

	str := lua.L_checkstring(state, 1)
	sub := lua.L_checkstring(state, 2)

	lua.pushboolean(state, b32(strings.starts_with(string(str), string(sub))))

	return 1
}

StringEndsWith :: proc "c" (state: ^lua.State) -> i32 {
	context = runtime.default_context()

	str := lua.L_checkstring(state, 1)
	sub := lua.L_checkstring(state, 2)

	lua.pushboolean(state, b32(strings.ends_with(string(str), string(sub))))

	return 1
}