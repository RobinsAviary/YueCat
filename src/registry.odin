package YueCat

import "core:fmt"
import lua "vendor:lua/5.4"

draw_registry: Registry = {
	"Draw",
	{
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
		{BeginScissor, "BeginScissor"},
		{EndScissor, "EndScissor"},
		{DrawRectangleGradientV, "RectangleGradientV"},
		{DrawRectangleGradientH, "RectangleGradientH"},
		{DrawRectangleGradient, "RectangleGradient"},
		{DrawRectangleRounded, "RectangleRounded"},
		{DrawRectangleRoundedLined, "RectangleRoundedLined"},
		{DrawTextEx, "TextEx"},
	},
}

keyboard_registry: Registry = {
	"Keyboard",
	{
		{IsKeyboardKeyReleased, "IsKeyReleased"},
		{IsKeyboardKeyPressed, "IsKeyPressed"},
		{IsKeyboardKeyHeld, "IsKeyHeld"},
	},
}

engine_registry: Registry = {
	"Engine",
	{
		{OpenURL, "OpenURL"},
		{GetTime, "GetTime"},
		{GetDelta, "GetDelta"},
		{GetFPS, "GetFPS"},
		{SetFPSTarget, "SetFPSTarget"},
		{SetClipboard, "SetClipboard"},
		{GetClipboard, "GetClipboard"},
		{SetExitKey, "SetExitKey"},
		{Sleep, "Sleep"},
		{TakeScreenshot, "TakeScreenshot"},
	},
}

mouse_registry: Registry = {
	"Mouse",
	{
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
		{GetMouseWheelMove, "GetWheelMove"},
		{GetMouseWheelMoveVector, "GetWheelMoveVector"},
	},
}

texture_registry: Registry = {
	"Texture",
	{
		{LoadTexture, "Load"},
		{UnloadTexture, "Unload"},
		{TextureGetSize, "GetSize"},
		{TextureGetWidth, "GetWidth"},
		{TextureGetHeight, "GetHeight"},
	},
}

audio_registry: Registry = {
	"Audio",
	{
		{LoadAudio, "Load"},
		{UnloadAudio, "Unload"},
		{PlayAudio, "Play"},
		{SetMasterVolume, "SetMasterVolume"},
		{GetMasterVolume, "GetMasterVolume"},
		{AudioGetChannelCount, "GetChannelCount"},
		{AudioGetFrameCount, "GetFrameCount"},
		{AudioGetSampleRate, "GetSampleRate"},
		{AudioGetSampleSize, "GetSampleSize"},
		{AudioSetVolume, "SetVolume"},
		{AudioSetPitch, "SetPitch"},
		{AudioSetPan, "SetPan"},
		{StopAudio, "Stop"},
		{PauseAudio, "Pause"},
		{ResumeAudio, "Resume"},
		{IsAudioPlaying, "IsPlaying"},
	},
}

color_registry: Registry = {
	"Color",
	{
		{ColorToHSV, "ToHSV"},
		{ColorFromHSV, "FromHSV"},
	},
}

controller_registry: Registry = {
	"Controller",
	{
		{IsControllerButtonHeld, "IsButtonHeld"},
		{GetControllerAxis, "GetAxis"},
		{GetControllerVector, "GetVector"},
		{GetControllerName, "GetName"},
		{ControllerSetDeadzone, "SetDeadzone"},
		{ControllerGetDeadzone, "GetDeadzone"},
		{ControllerSetDefaultDeadzone, "SetDefaultDeadzone"},
		{ControllerGetDefaultDeadzone, "GetDefaultDeadzone"},
		{IsControllerButtonPressed,"IsButtonPressed"},
		{IsControllerButtonReleased, "IsButtonReleased"},
	},
}

window_registry: Registry = {
	"Window",
	{
		{MaximizeWindow, "Maximize"},
		{MinimizeWindow, "Minimize"},
		{RestoreWindow, "Restore"},
		{SetWindowPosition, "SetPosition"},
		{SetWindowTitle, "SetTitle"},
		{SetWindowSizeMinimum, "SetMinimumSize"},
		{SetWindowSizeMaximum, "SetMaximumSize"},
		{SetWindowSize, "SetSize"},
		{GetWindowSize, "GetSize"},
		{GetWindowWidth, "GetWidth"},
		{GetWindowHeight, "GetHeight"},
		{SetWindowOpacity, "SetOpacity"},
		{GetWindowPosition, "GetPosition"},
		{SetWindowMonitor, "SetMonitor"},
		{GetCurrentMonitor, "GetCurrentMonitor"},
	},
}

cursor_registry: Registry = {
	"Cursor",
	{
		{ShowCursor, "Show"},
		{HideCursor, "Hide"},
		{IsCursorHidden, "IsHidden"},
		{IsCursorOnScreen, "IsOnScreen"},
	},
}

touch_registry: Registry = {
	"Touch",
	{
		{GetTouchX, "GetX"},
		{GetTouchY, "GetY"},
		{GetTouchPosition, "GetPosition"},
		{GetTouchPointId, "GetPointId"},
		{GetTouchPointCount, "GetPointCount"},
	},
}

time_registry: Registry = {
	"Time",
	{
		{Now, "Now"},
		{Weekday, "Weekday"},
		{Year, "Year"},
		{Month, "Month"},
		{IsLeapYear, "IsLeapYear"},
		{FromNanoseconds, "FromNanoseconds"},
		{Day, "Day"},
		//{Date, "Date"},
	},
}

font_registry: Registry = {
	"Font",
	{
		{LoadFont, "Load"},
		{UnloadFont, "Unload"},
		{GetDefaultFont, "GetDefault"},
	},
}

monitor_registry: Registry = {
	"Monitor",
	{
		{GetMonitorCount, "GetCount"},
		{GetMonitorPosition, "GetPosition"},
		{GetMonitorWidth, "GetWidth"},
		{GetMonitorHeight, "GetHeight"},
		{GetMonitorSize, "GetSize"},
		{GetMonitorPhysicalWidth, "GetPhysicalWidth"},
		{GetMonitorPhysicalHeight, "GetPhysicalHeight"},
		{GetMonitorPhysicalSize, "GetPhysicalSize"},
		{GetMonitorRefreshRate, "GetRefreshRate"},
		{GetMonitorName, "GetMonitorName"},
	},
}

music_registry: Registry = {
	"Music",
	{
		{LoadMusic, "Load"},
		{UnloadMusic, "Unload"},
		{PlayMusicStream, "PlayStream"},
		{IsMusicStreamPlaying, "IsStreamPlaying"},
		{StopMusicStream, "StopStream"},
		{PauseMusicStream, "PauseStream"},
		{ResumeMusicStream, "ResumeStream"},
		{SeekMusicStream, "SeekStream"},
		{SetMusicVolume, "SetVolume"},
		{SetMusicPitch, "SetPitch"},
		{SetMusicPan, "SetPan"},
		{GetMusicTimeLength, "GetTimeLength"},
		{GetMusicStreamTimePlayed, "GetStreamTimePlayed"},
	},
}

registry_value :: struct {
	cfunction: lua.CFunction,
	lua_name: cstring,
}

Registry :: struct {
	name: cstring,
	values: []registry_value,
}

register_registry :: proc(state: ^lua.State, registry: Registry) {
	lua.checkstack(state, 1)
	lua.getglobal(state, registry.name)

	registry_len := i32(len(registry.values))
	lua.checkstack(state, registry_len)
	for value in registry.values {
		lua.pushcfunction(state, value.cfunction)
		lua.setfield(state, -2, value.lua_name)
	}

	lua.pop(state, 1)
}

register_functions :: proc(state: ^lua.State) {
	if config.verbose do fmt.println("Registering functions...")
	
	register_registry(state, draw_registry)

	register_registry(state, engine_registry)

	register_registry(state, mouse_registry)

	register_registry(state, texture_registry)

	register_registry(state, keyboard_registry)

	register_registry(state, audio_registry)

	register_registry(state, color_registry)

	register_registry(state, controller_registry)

	register_registry(state, window_registry)

	register_registry(state, cursor_registry)

	register_registry(state, time_registry)

	register_registry(state, font_registry)
	
	register_registry(state, monitor_registry)

	register_registry(state, music_registry)
}