Engine = {
	Ready = function()

	end,

	Step = function()

	end,

	Draw = function()

	end,

	Cleanup = function()

	end,

	Init = function()

	end,
}

Vector2 = {
	meta = {
		__name = "Vector2",
		__add = function(a, b)
			local v = Vector2.New(a.x + b.x, a.y + b.y)
			
			return v
		end,
		__sub = function(a, b)
			local v = Vector2.New(a.x - b.x, a.y - b.y)

			return v
		end,
		__mul = function(a, b)
			local v = Vector2.New(a.x * b.x, a.y * b.y)

			return v
		end,
		__div = function(a, b)
			local v = Vector2.New(a.x / b.x, a.y / b.y)

			return v
		end,
		__idiv = function(a, b)
			local v = Vector2.New(a.x // b.x, a.y // b.y)

			return v
		end,
		__mod = function(a,b)
			local v = Vector2.New(a.x % b.x, a.y % b.y)

			return v
		end,
		__pow = function(a,b)
			local v = Vector2.New(a.x ^ b.x, a.y ^ b.y)

			return v
		end,
		__unm = function(a)
			local v = Vector2.New(-a.x, -a.y)
			
			return v
		end,
		__eq = function(a, b)
			return a.x == b.x and a.y == b.y
		end,
		__tostring = function(a)
			return "{Vector2: " .. a.x .. ", " .. a.y .. "}"
		end,
		__len = function(a)
			return math.sqrt(a.x * a.x + a.y * a.y)
		end,
	}
}

Vector2.New = function(x, y)
	x = x or 0
	y = y or x or 0

	local tbl = {
		x = x,
		y = y,
	}

	setmetatable(tbl, Vector2.meta)

	return tbl
end

Vector2.Zero = Vector2.New()

Vector2.Up = Vector2.New(0, 1)
Vector2.Down = Vector2.New(0, -1)
Vector2.Left = Vector2.New(-1, 0)
Vector2.Right = Vector2.New(1, 0)



Vector3 = {
	meta = {
		__name = "Vector3",
		__add = function(a, b)
			a.x = a.x + b.x
			a.y = a.y + b.y
			a.z = a.z + b.z
			
			return a
		end,
		__sub = function(a, b)
			a.x = a.x - b.x
			a.y = a.y - b.y
			a.z = a.z - b.z

			return a
		end,
		__mul = function(a, b)
			a.x = a.x * b.x
			a.y = a.y * b.y
			a.z = a.z * b.z

			return a
		end,
		__div = function(a, b)
			a.x = a.x / b.x
			a.y = a.y / b.y
			a.z = a.z / b.z

			return a
		end,
		__idiv = function(a, b)
			a.x = math.floor(a.x / b.x)
			a.y = math.floor(a.y / b.y)
			a.z = math.floor(a.z / b.z)

			return a
		end,
		__mod = function(a,b)
			a.x = a.x % b.x
			a.y = a.y % a.y
			a.z = a.z % a.z

			return a
		end,
		__pow = function(a,b)
			a.x = a.x ^ b.x
			a.y = a.y ^ b.y
			a.z = a.z ^ a.z

			return a
		end,
		__unm = function(a)
			a.x = -a.x
			a.y = -a.y
			a.z = -a.z
			
			return a
		end,
		__eq = function(a, b)
			return a.x == b.x and a.y == b.y and a.z == b.z
		end,
		__tostring = function(a)
			return "{Vector3: " .. a.x .. ", " .. a.y .. ", " .. a.z .. "}"
		end,
		__len = function(a)
			return math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
		end,
	}
}

Vector3.New = function(x, y, z)
	x = x or 0
	y = y or x or 0
	z = z or y or x or 0

	local tbl = {
		x = x,
		y = y,
		z = z,
	}

	setmetatable(tbl, Vector3.meta)

	return tbl
end

Vector3.Zero = Vector3.New()



Color = {
	meta = {
		__name = "Color"
	}
}

-- Color.ToHSV()
-- Color.FromHSV()

Color.New = function(r, g, b, a)
	r = r or 0
	g = g or r or 0
	b = b or r or g or 0
	a = a or 1

	local tbl = {
		r = r,
		g = g,
		b = b,
		a = a,
	}

	setmetatable(tbl, Color.meta)

	return tbl
end

Color.White = Color.New(1)
Color.Black = Color.New()
Color.Gray = Color.New(.510)
Color.LightGray = Color.New(.784)
Color.DarkGray = Color.New(.314)
Color.Yellow = Color.New(.992, .976, 0)
Color.Gold = Color.New(1, .796, 0)
Color.Orange = Color.New(1, .631, 0)
Color.Pink = Color.New(1, .427, .761)
Color.Red = Color.New(.902, .161, .216)
Color.Maroon = Color.New(.745, .129, .216)
Color.Green = Color.New(0, .894, .188)
Color.Lime = Color.New(0, .620, .184)
Color.DarkGreen = Color.New(0, .459, .173)
Color.SkyBlue = Color.New(.4, .749, 1)
Color.Blue = Color.New(0, .475, .945)
Color.DarkBlue = Color.New(0, .322, .675)
Color.Purple = Color.New(.784, .478, 1)
Color.Violet = Color.New(.529, .235, .745)
Color.DarkPurple = Color.New(.439, .122, .494)
Color.Beige = Color.New(.827, .690, .514)
Color.Brown = Color.New(.498, .415, .310)
Color.DarkBrown = Color.New(.298, .247, .184)
Color.Transparent = Color.New(0, 0, 0, 0)
Color.Magenta = Color.New(1, 0, 1)
Color.RayWhite = Color.New(.961)



ColorHSV = {
	meta = {
		__name = "ColorHSV"
	}
}

ColorHSV.New = function(h, s, v, a)
	h = h or 0
	s = s or 1
	v = v or s or 1
	a = a or 1

	local tbl = {
		h = h,
		s = s,
		v = v,
		a = a,
	}

	setmetatable(tbl, ColorHSV.meta)

	return tbl
end

Rectangle = {
	meta = {
		__name = "Rectangle"
	}
}

Rectangle.New = function(position, size)
	local tbl = {
		position = position or Vector2.Zero,
		size = size or Vector2.Zero,
	}

	setmetatable(tbl, Rectangle.meta)

	return tbl
end



Circle = {
	meta = {
		__name = "Circle"
	}
}

Circle.New = function(position, radius)
	local tbl = {
		position = position or Vector2.Zero,
		radius = radius or 0
	}

	setmetatable(tbl, Circle.meta)

	return tbl
end

Triangle = {
	meta = {
		__name = "Triangle"
	}
}

Triangle.New = function(firstPoint, secondPoint, thirdPoint)
	local tbl = {
		firstPoint = firstPoint or Vector2.Zero,
		secondPoint = secondPoint or Vector2.Zero,
		thirdPoint = thirdPoint or Vector2.Zero,
	}
end



Cube = {
	meta = {
		__name = "Cube"
	}
}

Cube.New = function(position, size)
	position = position or Vector3.Zero
	size = size or 0

	local tbl = {
		position = position,
		size = size,
	}

	setmetatable(tbl, Cube.meta)

	return tbl
end

Box = {
	meta = {
		__name = "Box"
	}
}

Box.New = function(position, size)
	position = position or Vector3.Zero
	size = Vector3.Zero

	local tbl = {
		position = position,
		size = size,
	}

	setmetatable(tbl, Box.meta)

	return tbl
end

Sphere = {
	meta = {
		__name = "Sphere"
	}
}

Sphere.New = function(position, diameter)
	position = position or Vector3.Zero
	diameter = diameter or 0

	local tbl = {
		position = position,
		diameter = diameter,
	}

	setmetatable(tbl, Sphere.meta)

	return tbl
end

Cylinder = {
	meta = {
		__name = "Cylinder"
	}
}

Cylinder.New = function(position, diameter, height)
	position = position or Vector3.Zero
	diameter = diameter or 0
	height = height or 0

	local tbl = {
		position = position,
		diameter = diameter,
		height = height,
	}

	setmetatable(tbl, Cylinder.meta)

	return tbl
end

Triangle3D = {
	meta = {
		__name = "Triangle3D"
	}
}

Triangle3D.New = function(firstPoint, secondPoint, thirdPoint)
	firstPoint = firstPoint or Vector3.Zero
	secondPoint = secondPoint or Vector3.Zero
	thirdPoint = thirdPoint or Vector3.Zero

	local tbl = {
		firstPoint = firstPoint or Vector3.Zero,
		secondPoint = secondPoint or Vector3.Zero,
		thirdPoint = thirdPoint or Vector3.Zero,
	}

	setmetatable(tbl, Triangle3D.meta)

	return tbl
end



Draw = {}

Mouse = {}

Texture = {}

Keyboard = {
	Key = {
		Null = 0,
		Apostrophe = 39,
		Comma = 44,
		Minus = 45,
		Period = 46,
		Slash = 47,
		Zero = 48,
		One = 49,
		Two = 50,
		Three = 51,
		Four = 52,
		Five = 53,
		Six = 54,
		Seven = 55,
		Eight = 56,
		Nine = 57,
		Semicolon = 59,
		Equal = 61,
		A = 65,
		B = 66,
		C = 67,
		D = 68,
		E = 69,
		F = 70,
		G = 71,
		H = 72,
		I = 73,
		J = 74,
		K = 75,
		L = 76,
		M = 77,
		N = 78,
		O = 79,
		P = 80,
		Q = 81,
		R = 82,
		S = 83,
		T = 84,
		U = 85,
		V = 86,
		W = 87,
		X = 88,
		Y = 89,
		Z = 90,
		Bracket = {
			Left = 91,
			Right = 93,
		},
		BackSlash = 92,
		Grave = 96,
		Space = 32,
		Escape = 256,
		Enter = 257,
		Tab = 258,
		Backspace = 259,
		Insert = 260,
		Delete = 261,
		Right = 262,
		Left = 263,
		Down = 264,
		Up = 265,
		PageUp = 266,
		PageDown = 267,
		Home = 268,
		End = 269,
		CapsLock = 280,
		ScrollLock = 281,
		NumLock = 282,
		PrintScreen = 283,
		Pause = 284,
		F1 = 290,
		F2 = 291,
		F3 = 292,
		F4 = 293,
		F5 = 294,
		F6 = 295,
		F7 = 296,
		F8 = 297,
		F9 = 298,
		F10 = 299,
		F11 = 300,
		F12 = 301,
		Shift = {
			Left = 340,
			Right = 344,
		},
		Control = {
			Left = 341,
			Right = 345,
		},
		Alt = {
			Left = 342,
			Right = 346,
		},
		Super = {
			Left = 343,
			Right = 347,
		},
		KBMenu = 348,
		-- Keypad
		Keypad = {
			Zero = 320,
			One = 321,
			Two = 322,
			Three = 323,
			Four = 324,
			Five = 325,
			Six = 326,
			Seven = 327,
			Eight = 328,
			Nine = 329,
			Decimal = 330,
			Divide = 331,
			Multiply = 332,
			Subtract = 333,
			Add = 334,
			Enter = 335,
			Equal = 336,
		},
		-- Android buttons
		Button = {
			Back = 4,
			Menu = 5,
			VolumeUp = 24,
			VolumeDown = 25,
		}
	}
}

Audio = {}

Config = {
	Window = {
		size = Vector2.New(640, 480),
		title = "YueCat",

		Flags = {
			msaa = false, -- Antialiasing
            borderless = false, -- Undecorated window
            topmost = false, -- Window always stays on top
            resizable = false, -- Window is resizable
            vsync = false, -- Vsync
		},
	},
	
	Audio = {
		active = true,
	}
}



Camera3D = {
	meta = {
		__name = "Camera3D",
	},

	Projection = {
		Perspective = 0,
		Orthographic = 1,
	}
}

Camera3D.New = function(position, target, up, fov, projection)
	position = position or Vector2.Zero
	target = target or Vector2.Zero
	up = up or Vector2.Zero
	fov = fov or 45
	projection = projection or Camera3D.Projection.Perspective

	tbl = {
		position = position,
		target = target,
		up = up,
		fov = fov,
		projection = projection,
	}

	setmetatable(tbl, Camera3D.meta)

	return tbl
end

Controller = {
	Button = {
		Invalid = -1,
		A = 0,
		B = 1,
		X = 2,
		Y = 3,
		Back = 4,
		Guide = 5,
		Start = 6,
		LeftStick = 7,
		RightStick = 8,
		LeftShoulder = 9,
		RightShoulder = 10,
		DPad = {
			Up = 11,
			Down = 12,
			Left = 13,
			Right = 14,
		},
		Misc1 = 15,
		Paddle1 = 16,
		Paddle2 = 17,
		Paddle3 = 18,
		Paddle4 = 19,
		Touchpad = 20,
	},

	Axis = {
		Invalid = -1,
		Left = {
			x = 0,
			y = 1,
		},
		Right = {
			x = 2,
			y = 3,
		},
		Trigger = {
			Left = 4,
			Right = 5,
		}
	},

	Vector = {
		DPad = 0,
		Left = 1,
		Right = 2,
	},

	Connected = function(controller)
			
	end,

	Disconnected = function(index)

	end,
}

Window = {}