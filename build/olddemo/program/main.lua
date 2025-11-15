local pos = Vector2.New()
Engine.Init = function()
	Config.window.size = Vector2.New(900, 700)
	Config.window.title = "Window"
end
Engine.Ready = function()
	Engine.SetFPSTarget(60)
	tex = Texture.Load("marcillesmall.png")
	snd = Audio.Load("pickupCoin.wav")
	return print(tex)
end
Engine.Step = function()
	local moveDir = Vector2.New()
	if Keyboard.IsKeyHeld(Key.Right) then
		moveDir.x = moveDir.x + 1
	end
	if Keyboard.IsKeyHeld(Key.Left) then
		moveDir.x = moveDir.x - 1
	end
	if Keyboard.IsKeyHeld(Key.Up) then
		moveDir.y = moveDir.y - 1
	end
	if Keyboard.IsKeyHeld(Key.Down) then
		moveDir.y = moveDir.y + 1
	end
	if Keyboard.IsKeyPressed(Key.Space) then
		Audio.Play(snd)
	end
	pos = pos + (moveDir * Vector2.New(2) * Vector2.New(Engine.GetDelta() * 60))
end
Engine.Draw = function()
	Draw.Clear(Color.DarkGray)
	Draw.Line(Vector2.New(), Vector2.New(150, 100), Color.White)
	Draw.Rectangle(Rectangle.New(Vector2.New(25, 25), Vector2.New(16)), Color.Beige)
	if Mouse.IsButtonHeld(0) then
		Draw.CircleLined(Circle.New(Mouse.GetPosition(), 16), Color.Blue)
	end
	Draw.Texture(tex, Vector2.New(10, 50), Color.Red)
	Draw.Circle(Circle.New(pos, 32), Color.Blue)
	return Draw.Text("Hello, World!", Vector2.New(0, 0), Color.White)
end
Engine.Cleanup = function()
	Texture.Unload(tex)
	return Audio.Unload(snd)
end
