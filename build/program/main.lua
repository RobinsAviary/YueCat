circle = Circle.New(Vector2.New(400, 120), 32)
local cunt = nil
Controller.Connected = function(controller)
	cunt = controller
end
Controller.Disconnected = function(index)
	if cunt ~= nil then
		if cunt.index == index then
			cunt = nil
		end
	end
end
Engine.Init = function()
	Config.Window.size = Vector2.New(800, 450)
	Config.Window.Flags.msaa = true
	return Controller.SetDefaultDeadzone(.2)
end
Engine.Ready = function()
	return Engine.SetFPSTarget(60)
end
Engine.Step = function()
	if cunt ~= nil then
		local vec = Controller.GetVector(cunt, Controller.Vector.Left)
		local _obj_0 = circle
		_obj_0.position = _obj_0.position + (vec * Vector2.New(Engine.GetDelta() * 100))
	end
	if Keyboard.IsKeyPressed(Keyboard.Key.Space) then
		return print("Boing!")
	end
end
Engine.Draw = function()
	Draw.Clear(Color.White)
	Draw.Text("Congrats! You created your first window!", Vector2.New(190, 200), Color.LightGray)
	Draw.Circle(circle, Color.Red)
	if cunt ~= nil then
	end
end
Engine.Cleanup = function() end
