Engine.Init = function()
	Config.window.size = Vector2.New(800, 450)
end
Engine.Ready = function()
	return Engine.SetFPSTarget(60)
end
Engine.Step = function() end
Engine.Draw = function()
	Draw.Clear(Color.FromHSV(ColorHSV.New(180, 1, 1)))
	return Draw.Text("Congrats! You created your first window!", Vector2.New(190, 200), Color.LightGray)
end
Engine.Cleanup = function() end
