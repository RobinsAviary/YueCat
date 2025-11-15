local pos = Vector2.Zero()
Engine.Init = function()
	Config.window.size = Vector2(640, 480)
	Config.window.title = "yuecat alpha - basic window"
end
Engine.Ready = function()
	Engine.SetFPSTarget(60)
	rdr = RenderTexture.Load(Vector2(320, 240))
	Texture.BeginMode(rdr)
	Draw.Clear(Color.Red)
	return Texture.EndMode()
end
Engine.Step = function() end
Engine.Draw = function()
	Draw.Clear(Color.RayWhite)
	Draw.Line(Vector2.Zero, Vector2(640, 480), Color.Red)
	Draw.Line(Vector2(640, 0), Vector2(0, 480), Color.Red)
	return Draw.Texture(rdr)
end
Engine.Cleanup = function()
	return RenderTexture.Unload(rdr)
end
