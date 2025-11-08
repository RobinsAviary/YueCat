local pos = Vector2.New()
local windowSize = Vector2.New(800, 450)
local deltaCircle = Vector2.New(0, windowSize.y / 3)
local frameCircle = Vector2.New(0, windowSize.y * (2 / 3))
local speed = 10
local circleRadius = 32
Engine.Init = function()
	Config.window.size = windowSize
	Config.window.title = "raylib [core] example - delta time"
end
Engine.Ready = function()
	return Engine.SetFPSTarget(60)
end
Engine.Step = function()
	local mouseWheel = GetMouseWheelMove()
	if mouseWheel ~= 0 then
		local currentFps = currentFps + mouseWheel
		if currentFps < 0 then
			currentFps = 0
		end
		Engine.SetFPSTarget(currentFps)
	end
	deltaCircle.x = deltaCircle.x + (GetFrameTime() * 6 * speed)
	frameCircle.x = frameCircle.x + (.1 * speed)
	if deltaCircle.x > windowSize.x then
		deltaCircle.x = 0
	end
	if frameCircle.x > windowSize.x then
		frameCircle.x = 0
	end
	if Keyboard.IsKeyPressed(Keyboard.Key.R) then
		deltaCircle.x = 0
		frameCircle.x = 0
	end
end
Engine.Draw = function()
	Draw.Clear(Color.RayWhite)
	Draw.Circle(Circle.New(deltaCircle, circleRadius), Color.Red)
	Draw.Circle(Circle.New(frameCircle, circleRadius), Color.Blue)
	local fpsText = ""
end
Engine.Cleanup = function() end
