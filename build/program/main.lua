Engine.Init = function()
	Config.Window.size = Vector2(640, 480)
	Config.Window.title = "yuecat alpha - basic window"
end
Engine.Ready = function()
	return Engine.SetFPSTarget(60)
end
Engine.Step = function() end
Engine.Draw = function()
	Draw.Clear(Color.RayWhite)
	Draw.Line(Vector2.Zero, Vector2(640, 480), Color.Red)
	return Draw.Line(Vector2(640, 0), Vector2(0, 480), Color.Red)
end
Engine.Cleanup = function() end
