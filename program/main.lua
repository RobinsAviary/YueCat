camera = Camera3D.New(Vector3.New(10), Vector3.Zero, Vector3.New(0, 1, 0))
Engine.Init = function()
	Config.window.size = Vector2.New(800, 450)
end
Engine.Ready = function()
	return Engine.SetFPSTarget(60)
end
Engine.Step = function() end
Engine.Draw = function()
	Draw.Clear(Color.FromHSV(ColorHSV.New(180, 1, 1)))
	Engine.Begin3D(camera)
	Draw.Grid(100, 1)
	Draw.Box(Vector3.New(), Vector3.New(10, 20, 12), Color.Red)
	return Engine.End3D()
end
Engine.Cleanup = function() end
