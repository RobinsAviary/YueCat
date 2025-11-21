package YueCat

import "core:fmt"
import lua "vendor:lua/5.4"
import "core:c"

draw_registry := Registry {
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
		{DrawTexturePro, "TexturePro"},
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
		{DrawPixel, "Pixel"},
		{DrawLineStrip, "LineStrip"},
		{DrawSplineLinear, "SplineLinear"},
		{DrawSplineBasis, "SplineBasis"},
		{DrawSplineCatmullRom, "SplineCatmullRom"},
		{DrawSplineBezierQuadratic, "SplineBezierQuadratic"},
		{DrawSplineBezierCubic, "SplineBezierCubic"},
		{DrawSplineSegmentLinear, "SplineSegmentLinear"},
		{DrawSplineSegmentBasis, "SplineSegmentBasis"},
		{DrawSplineSegmentCatmullRom, "SplineSegmentCatmullRom"},
		{DrawSplineSegmentBezierQuadratic, "SplineSegmentBezierQuadratic"},
		{DrawSplineSegmentBezierCubic, "SplineSegmentBezierCubic"},
	},
}

keyboard_registry := Registry {
	"Keyboard",
	{
		{IsKeyboardKeyReleased, "IsKeyReleased"},
		{IsKeyboardKeyPressed, "IsKeyPressed"},
		{IsKeyboardKeyHeld, "IsKeyHeld"},
	},
}

engine_registry := Registry {
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

mouse_registry := Registry {
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

texture_registry := Registry {
	"Texture",
	{
		{LoadTexture, "Load"},
		{UnloadTexture, "Unload"},
		{TextureGetSize, "GetSize"},
		{TextureGetWidth, "GetWidth"},
		{TextureGetHeight, "GetHeight"},
		{BeginTextureMode, "BeginMode"},
		{EndTextureMode, "EndMode"},
		{SetTextureFilter, "SetFilter"},
		{SetTextureWrap, "SetWrap"},
	},
}

audio_registry := Registry {
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

color_registry := Registry {
	"Color",
	{
		{ColorToHSV, "ToHSV"},
		{ColorFromHSV, "FromHSV"},
		{ColorFade, "Fade"},
		{ColorToHex, "ToHex"},
		//{ColorNormalize, "Normalize"},
		//{ColorFromNormalized, "FromNormalized"},
		{ColorTint, "Tint"},
		{ColorBrightness, "Brightness"},
		{ColorContrast, "Contrast"},
		{ColorAlpha, "Alpha"},
		{ColorAlphaBlend, "AlphaBlend"},
		{ColorLerp, "Lerp"},
		{ColorFromHex, "FromHex"},
	},
}

controller_registry := Registry {
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

window_registry := Registry {
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

cursor_registry := Registry {
	"Cursor",
	{
		{ShowCursor, "Show"},
		{HideCursor, "Hide"},
		{IsCursorHidden, "IsHidden"},
		{IsCursorOnScreen, "IsOnScreen"},
	},
}

touch_registry := Registry {
	"Touch",
	{
		{GetTouchX, "GetX"},
		{GetTouchY, "GetY"},
		{GetTouchPosition, "GetPosition"},
		{GetTouchPointId, "GetPointId"},
		{GetTouchPointCount, "GetPointCount"},
	},
}

time_registry := Registry {
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

font_registry := Registry {
	"Font",
	{
		{LoadFont, "Load"},
		{UnloadFont, "Unload"},
		{GetDefaultFont, "GetDefault"},
	},
}

monitor_registry := Registry {
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

music_registry := Registry {
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

rendertexture_registry := Registry {
	"RenderTexture",
	{
		{LoadRenderTexture, "Load"},
		{UnloadRenderTexture, "Unload"},
	},
}

sound_registry := Registry {
	"Sound",
	{
		{LoadSound, "Load"},
		{UnloadSound, "Unload"},
	},
}

spline_registry := Registry {
	"Spline",
	{
		{GetSplinePointLinear, "GetPointLinear"},
		{GetSplinePointBasis, "GetPointBasis"},
		{GetSplinePointCatmullRom, "GetPointCatmullRom"},
		{GetSplinePointBezierQuad, "GetPointBezierQuad"},
		{GetSplinePointBezierCubic, "GetPointBezierCubic"},
	},
}

image_registry: Registry = {
	"Image",
	{
		{LoadImage, "Load"},
		{UnloadImage, "Unload"},
		{GenerateImageColor, "GenerateColor"},
		{GenerateImageGradientLinear, "GenerateGradientLinear"},
		{GenerateImageGradientRadial, "GenerateGradientRadial"},
		{GenerateImageGradientSquare, "GenerateGradientSquare"},
		{GenerateImageCheckered, "GenerateCheckered"},
		{GenerateImageWhiteNoise, "GenerateWhiteNoise"},
		{GenerateImagePerlinNoise, "GeneratePerlinNoise"},
		{GenerateImageCellular, "GenerateCellular"},
		{GenerateImageText, "GenerateText"},
		{ImageCopy, "Copy"},
		{ImageFromRectangle, "FromRectangle"},
		{ImageFromChannel, "FromChannel"},
		{ImageText, "Text"},
		{ImageCrop, "Crop"},
		{ImageAlphaCrop, "AlphaCrop"},
		{ImageAlphaClear, "AlphaClear"},
		{ImageAlphaMask, "AlphaMask"},
		{ImageAlphaPremultiply, "AlphaPremultiply"},
		{ImageBlurGaussian, "BlurGaussian"},
		{ImageResizeBilinear, "ResizeBilinear"},
		{ImageResizeNN, "Resize"},
		{ImageMipmaps, "Mipmaps"},
		{ImageDither, "Dither"},
		{ImageFlipVertical, "FlipVertical"},
		{ImageFlipHorizontal, "FlipHorizontal"},
		{ImageRotate, "Rotate"},
		{ImageRotateCW, "RotateClockwise"},
		{ImageRotateCCW, "RotateCounterClockwise"},
		{ImageColorTint, "Tint"},
		{ImageColorInvert, "Invert"},
		{ImageColorGrayscale, "Grayscale"},
		{ImageColorContrast, "Contrast"},
		{ImageColorBrightness, "Brightness"},
		{ImageColorReplace, "ColorReplace"},
		{GetImageColor, "GetColor"},
		{GetImageAlphaBorder, "GetAlphaBorder"},
	},
}

image_draw_registry := Registry {
	"Draw",
	{
		{ImageDrawLine, "Line"},
		{ImageDrawCircle, "Circle"},
		{ImageDrawCircleLined, "CircleLined"},
		{ImageDrawRectangle, "Rectangle"},
		{ImageDrawRectangleLined, "RectangleLined"},
		{ImageDrawTriangle, "Triangle"},
		{ImageDrawTriangleLined, "TriangleLined"},
		{ImageDrawText, "Text"},
		{ImageDrawTextEx, "TextEx"},
	},
}

vertex_registry := Registry {
	"Vertex",
	{
		{VertexBegin, "Begin"},
		{VertexEnd, "End"},
		{VertexPosition2, "Position2"},
		{VertexPosition3, "Position3"},
		{VertexUV, "UV"},
		{VertexColor, "Color"},
		{VertexNormal3, "Normal"},
		{VertexSetTexture, "SetTexture"},
		{EnableWireMode, "EnableWireMode"},
		{EnablePointMode, "EnablePointMode"},
		{DisableWirePointMode, "DisableWirePointMode"},
		{SetCullMode, "SetCullMode"},
	},
}

collision_registry := Registry {
	"Collision",
	{
		{CheckCollisionRectangles, "CheckRectangles"},
		{CheckCollisionCircles, "CheckCircles"},
		{CheckCollisionCircleRectangle, "CheckCircleRectangle"},
		{CheckCollisionCircleLine, "CheckCircleLine"},
		{CheckCollisionPointRectangle, "CheckPointRectangle"},
		{CheckCollisionPointCircle, "CheckPointCircle"},
		{CheckCollisionPointTriangle, "CheckPointTriangle"},
		{CheckCollisionPointLine, "CheckCollisionPointLine"},
		{GetCollisionRectangle, "GetRectangle"},
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

register_registry :: proc(state: ^lua.State, tblidx: c.int = -1, registry: Registry) {
	registry_len := i32(len(registry.values))
	lua.checkstack(state, registry_len)
	for value in registry.values {
		lua.pushcfunction(state, value.cfunction)
		lua.setfield(state, tblidx - 1, value.lua_name)
	}
}

register_registries :: proc(state: ^lua.State, registries: []Registry) {
	lua.checkstack(state, c.int(len(registries)))
	
	for registry in registries {
		lua.getglobal(state, registry.name)

		lua.checkstack(state, c.int(len(registry.values)))
		for value in registry.values {
			lua.pushcfunction(state, value.cfunction)
			lua.setfield(state, -2, value.lua_name)
		}
	}

	lua.pop(state, c.int(len(registries)))
}

register_functions :: proc(state: ^lua.State) {
	if config.verbose do fmt.println("Registering functions...")
	
	registries := []Registry {
		draw_registry,
		engine_registry,
		mouse_registry,
		texture_registry,
		keyboard_registry,
		audio_registry,
		color_registry,
		controller_registry,
		window_registry,
		cursor_registry,
		time_registry,
		font_registry,
		monitor_registry,
		music_registry,
		rendertexture_registry,
		image_registry,
		vertex_registry,
		collision_registry,
	}

	register_registries(state, registries)

	// Register Image.Draw
	lua.checkstack(state, 2)
	lua.getglobal(state, "Image")
	lua.getfield(state, -1, "Draw")
	register_registry(state, -1, image_draw_registry)
	lua.pop(state, 2)
}