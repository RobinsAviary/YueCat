package YueCat

import "core:fmt"
import lua "vendor:lua/5.4"

KEYBOARD_REGISTRY :: "Keyboard"
DRAW_REGISTRY :: "Draw"
ENGINE_REGISTRY :: "Engine"
MOUSE_REGISTRY :: "Mouse"
TEXTURE_REGISTRY :: "Texture"
AUDIO_REGISTRY :: "Audio"
COLOR_REGISTRY :: "Color"
CONTROLLER_REGISTRY :: "Controller"

draw_registry: Registry = {
	{DrawClear, "Clear"},
	{DrawLine, "Line"},
	{DrawRectangle, "Rectangle"},
	{DrawRectangleLined, "RectangleLined"},
	{DrawCircleLined, "CircleLined"},
	{DrawCircle, "Circle"},
	{DrawTriangle, "Triangle"},
	{DrawTriangleLined, "TriangleLined"},
	{DrawTexture, "Texture"},
	{DrawText, "Text"},
	{DrawGrid, "Grid"},
	{DrawCube, "Cube"},
	{DrawBox, "Box"},
	{Begin3D, "Begin3D"},
	{End3D, "End3D"},
	{DrawFPS, "FPS"},
}

keyboard_registry: Registry = {
	{IsKeyboardKeyReleased, "IsKeyReleased"},
	{IsKeyboardKeyPressed, "IsKeyPressed"},
	{IsKeyboardKeyHeld, "IsKeyHeld"},
}

engine_registry: Registry = {
	{OpenURL, "OpenURL"},
	{GetTime, "GetTime"},
	{GetDelta, "GetDelta"},
	{GetFPS, "GetFPS"},
	{SetFPSTarget, "SetFPSTarget"},
}

mouse_registry: Registry = {
	{GetMousePosition, "GetPosition"},
	{GetMouseX, "GetX"},
	{GetMouseY, "GetY"},
	{SetMouseX, "SetX"},
	{SetMouseY, "SetY"},
	{SetMousePosition, "SetPosition"},
	{IsMouseButtonPressed, "IsButtonPressed"},
	{IsMouseButtonHeld, "IsButtonHeld"},
	{IsMouseButtonReleased, "IsButtonReleased"},
	{IsCursorOnScreen, "IsOnScreen"},
}

texture_registry: Registry = {
	{LoadTexture, "Load"},
	{UnloadTexture, "Unload"},
}

audio_registry: Registry = {
	{LoadAudio, "Load"},
	{UnloadAudio, "Unload"},
	{PlayAudio, "Play"},
}

color_registry: Registry = {
	{ColorToHSV, "ToHSV"},
	{ColorFromHSV, "FromHSV"},
}

controller_registry: Registry = {
	{IsControllerButtonHeld, "IsButtonHeld"},
	{GetControllerAxis, "GetAxis"},
	{GetControllerVector, "GetVector"},
	{GetControllerName, "GetName"},
	{ControllerSetDeadzone, "SetDeadzone"},
	{ControllerGetDeadzone, "GetDeadzone"},
	{ControllerSetDefaultDeadzone, "SetDefaultDeadzone"},
	{ControllerGetDefaultDeadzone, "GetDefaultDeadzone"},
}

registry_value :: struct {
	cfunction: lua.CFunction,
	lua_name: cstring,
}

Registry :: []registry_value

register_registry :: proc(state: ^lua.State, registry: Registry) {
	registry_len := i32(len(registry))
	lua.checkstack(state, registry_len)
	for value in registry {
		lua.pushcfunction(state, value.cfunction)
		lua.setfield(state, -2, value.lua_name)
	}
}

register_functions :: proc(state: ^lua.State) {
	if config.verbose do fmt.println("Registering functions...")

	lua.checkstack(state, 1)
	lua.getglobal(state, DRAW_REGISTRY)
	register_registry(state, draw_registry)
	lua.pop(state, 1)

	lua.checkstack(state, 1)
	lua.getglobal(state, ENGINE_REGISTRY)
	register_registry(state, engine_registry)
	lua.pop(state, 1)

	lua.checkstack(state, 1)
	lua.getglobal(state, MOUSE_REGISTRY)
	register_registry(state, mouse_registry)
	lua.pop(state, 1)

	lua.checkstack(state, 1)
	lua.getglobal(state, TEXTURE_REGISTRY)
	register_registry(state, texture_registry)
	lua.pop(state, 1)

	lua.checkstack(state, 1)
	lua.getglobal(state, KEYBOARD_REGISTRY)
	register_registry(state, keyboard_registry)
	lua.pop(state, 1)

	lua.checkstack(state, 1)
	lua.getglobal(state, AUDIO_REGISTRY)
	register_registry(state, audio_registry)
	lua.pop(state, 1)

	lua.checkstack(state, 1)
	lua.getglobal(state, COLOR_REGISTRY)
	register_registry(state, color_registry)
	lua.pop(state, 1)

	lua.checkstack(state, 1)
	lua.getglobal(state, CONTROLLER_REGISTRY)
	register_registry(state, controller_registry)
	lua.pop(state, 1)

	/*lua.checkstack(state, 1)
	lua.getglobal(state, GAMEPAD_REGISTRY)
	register(state, IsGamepadConnected, "IsConnected")
	register(state, GetGamepadName, "GetName")
	register(state, GetGamepadAxisCount, "GetAxisCount")
	register(state, GetGamepadAxis, "GetAxis")
	register(state, GetGamepadVector, "GetVector")
	register(state, IsGamepadButtonHeld, "IsButtonHeld")
	register(state, IsGamepadButtonPressed, "IsButtonPressed")
	register(state, IsGamepadButtonReleased, "IsButtonReleased")
	register(state, SetGamepadVibration, "SetVibration")
	lua.pop(state, 1)*/
}