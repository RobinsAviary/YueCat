local cont = nil
Textures = { }
local slots = {
	Vector2.New(152, 91),
	Vector2.New(247, 91),
	Vector2.New(342, 91)
}
local slot_positions = {
	0,
	0,
	0
}
Controller.Connected = function(controller)
	cont = controller
end
Controller.Disconnected = function(index)
	if cont ~= nil then
		if cont.index == index then
			cont = nil
		end
	end
end
Engine.Init = function()
	Config.Window.size = Vector2.New(455, 360)
	Config.Window.title = "raylib [core] example - basic window"
	Config.Window.Flags.msaa = true
	return Controller.SetDefaultDeadzone(.2)
end
Engine.Ready = function()
	Engine.SetFPSTarget(144)
	Textures.fruits = Texture.Load("resources/fruits.png")
	Textures.coin = Texture.Load("resources/coin.png")
	Textures.cointilt = Texture.Load("resources/cointilt.png")
	Textures.machineback = Texture.Load("resources/machineback.png")
	Textures.insertback = Texture.Load("resources/machineback2.png")
	Textures.slotback = Texture.Load("resources/slotback.png")
	Textures.slotoverlay = Texture.Load("resources/slotoverlay.png")
end
Engine.Step = function()
	if cont ~= nil then
		local vec = Controller.GetVector(cont, Controller.Vector.Left)
	end
end
Engine.Draw = function()
	Draw.Clear(Color.White)
	Draw.Text("Congrats! You created your first window!", Vector2.New(190, 200), Color.LightGray)
	Draw.Texture(Textures.insertback, Vector2.New(372, 4))
	Draw.Texture(Textures.coin, Vector2.New(377, 0))
	Draw.Texture(Textures.machineback)
	for _, slot in pairs(slots) do
		Draw.Texture(Textures.slotback, slot)
		Draw.BeginScissor(Rectangle.New(slot + Vector2.New(2), Vector2.New(77, 130) - Vector2.New(4)))
		Draw.Texture(Textures.fruits, slot + Vector2.New(8, 0))
		Draw.EndScissor()
		Draw.Texture(Textures.slotoverlay, slot + Vector2.New(-10, 2))
	end
end
Engine.Cleanup = function()
	for _, texture in pairs(Textures) do
		Texture.Unload(texture)
	end
end
