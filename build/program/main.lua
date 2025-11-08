local cont = nil
Textures = { }
Sounds = { }
local spot_kind = {
	orange = {
		position = 21
	},
	watermelon = {
		position = 61
	},
	coconut = {
		position = 97
	},
	bell = {
		position = 136
	},
	pear = {
		position = 177
	},
	bar = {
		position = 217
	},
	seven = {
		position = 254
	},
	cherry = {
		position = 296
	}
}
local slots = {
	{
		position = Vector2(152, 91),
		speed = 1,
		offset = 0,
		stop_at = nil
	},
	{
		position = Vector2(247, 91),
		speed = .8,
		offset = 0,
		stop_at = nil
	},
	{
		position = Vector2(342, 91),
		speed = .4,
		offset = 0,
		stop_at = nil
	}
}
local Timer = {
	current = 0,
	max = .1
}
local slots_rolling = true
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
	Config.Window.size = Vector2(455, 360)
	Config.Window.title = "raylib [core] example - basic window"
	Config.Window.Flags.msaa = true
	return Controller.SetDefaultDeadzone(.2)
end
Engine.Ready = function()
	Engine.SetFPSTarget(144)
	Textures.fruits = Texture.Load("resources/textures/fruits.png")
	Textures.coin = Texture.Load("resources/textures/coin.png")
	Textures.cointilt = Texture.Load("resources/textures/cointilt.png")
	Textures.machineback = Texture.Load("resources/textures/machineback.png")
	Textures.insertback = Texture.Load("resources/textures/machineback2.png")
	Textures.slotback = Texture.Load("resources/textures/slotback.png")
	Textures.slotoverlay = Texture.Load("resources/textures/slotoverlay.png")
	Sounds.tick = Audio.Load("resources/audio/click.wav")
	Audio.SetMasterVolume(0)
	return math.DistanceAngle(500, .5 * math.pi)
end
Engine.Step = function()
	if cont ~= nil then
		local vec = Controller.GetVector(cont, Controller.Vector.Left)
	end
	if not slots_rolling and Timer.current ~= 0 then
		Timer.current = 0
	end
	if slots_rolling then
		Timer.current = Timer.current + Engine.GetDelta()
		for _index_0 = 1, #slots do
			local slot = slots[_index_0]
			slot.offset = slot.offset - (slot.speed * Engine.GetDelta() * 500)
			if slot.offset < -Texture.GetHeight(Textures.fruits) then
				slot.offset = 0
			end
		end
	end
	if Timer.current > Timer.max then
		Timer.current = 0
	end
	if Keyboard.IsKeyPressed(Keyboard.Key.Space) then
		return print(table.randomkey(spot_kind))
	end
end
Engine.Draw = function()
	Draw.Clear(Color.RayWhite)
	Draw.Texture(Textures.insertback, Vector2(372, 4))
	Draw.Texture(Textures.coin, Vector2(377, 0))
	Draw.Texture(Textures.machineback)
	for _index_0 = 1, #slots do
		local slot = slots[_index_0]
		Draw.Texture(Textures.slotback, slot.position)
		Draw.BeginScissor(Rectangle(slot.position + Vector2(2), Vector2(77, 130) - Vector2(4)))
		Draw.Texture(Textures.fruits, slot.position + Vector2(0, slot.offset) + Vector2(8, 0))
		Draw.Texture(Textures.fruits, slot.position + Vector2(0, slot.offset + Texture.GetHeight(Textures.fruits)) + Vector2(8, 0))
		Draw.EndScissor()
		Draw.Texture(Textures.slotoverlay, slot.position + Vector2(0, 2))
	end
	return Draw.FPS()
end
Engine.Cleanup = function()
	for _, texture in pairs(Textures) do
		Texture.Unload(texture)
	end
	for _, sound in pairs(Sounds) do
		Audio.Unload(sound)
	end
end
