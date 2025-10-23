package YueCat

import lua "vendor:lua/5.4"

KeyboardRegistry :: "Keyboard"
DrawRegistry :: "Draw"
EngineRegistry :: "Engine"
MouseRegistry :: "Mouse"

register_functions :: proc(state: ^lua.State) {
	lua.getglobal(state, DrawRegistry)
	register(state, DrawClear, "Clear")
	register(state, DrawLine, "Line")
	register(state, DrawRectangle, "Rectangle")
    register(state, DrawRectangleLined, "RectangleLined")
    register(state, DrawCircleLined, "CircleLined")
	register(state, DrawCircle, "Circle")
    register(state, DrawTriangle, "Triangle")
    register(state, DrawTriangleLined, "TriangleLined")
	register(state, DrawTexture, "Texture")
	register(state, DrawText, "Text")
	register(state, DrawGrid, "Grid")
	lua.pop(state, 1)

	lua.getglobal(state, EngineRegistry)
	register(state, OpenURL, "OpenURL")
	register(state, GetTime, "GetTime")
	register(state, GetDelta, "GetDelta")
	register(state, GetFPS, "GetFPS")
	register(state, SetFPSTarget, "SetFPSTarget")
	register(state, LoadTexture, "LoadTexture")
	register(state, UnloadTexture, "UnloadTexture")
	register(state, Begin3D, "Begin3D")
	register(state, End3D, "End3D")
	lua.pop(state, 1)

	lua.getglobal(state, MouseRegistry)
	register(state, GetMousePosition, "GetPosition")
	register(state, GetMouseX, "GetX")
	register(state, GetMouseY, "GetY")
	register(state, SetMouseX, "SetX")
	register(state, SetMouseY, "SetY")
	register(state, SetMousePosition, "SetPosition")
	register(state, IsMouseButtonPressed, "IsButtonPressed")
	register(state, IsMouseButtonHeld, "IsButtonHeld")
	register(state, IsMouseButtonReleased, "IsButtonReleased")
	lua.pop(state, 1)

	lua.getglobal(state, "Texture")
	register(state, LoadTexture, "Load")
	register(state, UnloadTexture, "Unload")
	lua.pop(state, 1)

	lua.getglobal(state, KeyboardRegistry)
	register(state, IsKeyboardKeyReleased, "IsKeyReleased")
	register(state, IsKeyboardKeyPressed, "IsKeyPressed")
	register(state, IsKeyboardKeyHeld, "IsKeyHeld")
	lua.pop(state, 1)

	lua.getglobal(state, "Audio")
	register(state, LoadAudio, "Load")
	register(state, UnloadAudio, "Unload")
	register(state, PlayAudio, "Play")
	lua.pop(state, 1)

	lua.getglobal(state, "Color")
	register(state, ColorToHSV, "ToHSV")
	register(state, ColorFromHSV, "FromHSV")
	lua.pop(state, 1)
}