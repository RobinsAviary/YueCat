Engine = {
	Ready = function() end,
	Step = function() end,
	Draw = function() end,
	Cleanup = function() end,
	Init = function() end
}
Vector2 = {
	meta = {
		__name = "Vector2",
		__add = function(a, b)
			local v = Vector2(a.x + b.x, a.y + b.y)
			return v
		end,
		__sub = function(a, b)
			local v = Vector2(a.x - b.x, a.y - b.y)
			return v
		end,
		__mul = function(a, b)
			local v = Vector2(a.x * b.x, a.y * b.y)
			return v
		end,
		__div = function(a, b)
			local v = Vector2(a.x / b.x, a.y / b.y)
			return v
		end,
		__idiv = function(a, b)
			local v = Vector2(a.x // b.x, a.y // b.y)
			return v
		end,
		__mod = function(a, b)
			local v = Vector2(a.x % b.x, a.y % b.y)
			return v
		end,
		__pow = function(a, b)
			local v = Vector2(a.x ^ b.x, a.y ^ b.y)
			return v
		end,
		__unm = function(a)
			local v = Vector2(-a.x, -a.y)
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
		__call = function(_, x, y)
			x = x or 0
			y = y or x or 0
			local tbl = {
				x = x,
				y = y
			}
			setmetatable(tbl, Vector2.meta)
			return tbl
		end
	}
}
setmetatable(Vector2, Vector2.meta)
Vector2.Zero = Vector2()
Vector2.Up = function()
	return Vector2(0, 1)
end
Vector2.Down = function()
	return Vector2(0, -1)
end
Vector2.Left = function()
	return Vector2(-1, 0)
end
Vector2.Right = function()
	return Vector2(1, 0)
end
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
		__mod = function(a, b)
			a.x = a.x % b.x
			a.y = a.y % a.y
			a.z = a.z % a.z
			return a
		end,
		__pow = function(a, b)
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
		__call = function(_, x, y, z)
			x = x or 0
			y = y or x or 0
			z = z or y or x or 0
			local tbl = {
				x = x,
				y = y,
				z = z
			}
			setmetatable(tbl, Vector3.meta)
			return tbl
		end
	}
}
setmetatable(Vector3, Vector3.meta)
Vector3.Zero = function()
	return Vector3()
end
Color = {
	meta = {
		__name = "Color",
		__call = function(_, r, g, b, a)
			r = r or 0
			g = g or r or 0
			b = b or g or r or 0
			a = a or 1
			local tbl = {
				r = r,
				g = g,
				b = b,
				a = a
			}
			setmetatable(tbl, Color.meta)
			return tbl
		end
	}
}
setmetatable(Color, Color.meta)
Color.White = Color(1)
Color.Black = Color()
Color.Gray = Color(.510)
Color.LightGray = Color(.784)
Color.DarkGray = Color(.314)
Color.Yellow = Color(.992, .976, 0)
Color.Gold = Color(1, .796, 0)
Color.Orange = Color(1, .631, 0)
Color.Pink = Color(1, .427, .761)
Color.Red = Color(.902, .161, .216)
Color.Maroon = Color(.745, .129, .216)
Color.Green = Color(0, .894, .188)
Color.Lime = Color(0, .620, .184)
Color.DarkGreen = Color(0, .459, .173)
Color.SkyBlue = Color(.4, .749, 1)
Color.Blue = Color(0, .475, .945)
Color.DarkBlue = Color(0, .322, .675)
Color.Purple = Color(.784, .478, 1)
Color.Violet = Color(.529, .235, .745)
Color.DarkPurple = Color(.439, .122, .494)
Color.Beige = Color(.827, .690, .514)
Color.Brown = Color(.498, .415, .310)
Color.DarkBrown = Color(.298, .247, .184)
Color.Transparent = Color(0, 0, 0, 0)
Color.Magenta = Color(1, 0, 1)
Color.RayWhite = Color(.961)
ColorHSV = {
	meta = {
		__name = "ColorHSV",
		__call = function(_, h, s, v, a)
			h = h or 0
			s = s or 1
			v = v or s or 1
			a = a or 1
			local tbl = {
				h = h,
				s = s,
				v = v,
				a = a
			}
			setmetatable(tbl, ColorHSV.meta)
			return tbl
		end
	}
}
setmetatable(ColorHSV, ColorHSV.meta)
Rectangle = {
	meta = {
		__name = "Rectangle",
		__call = function(_, position, size)
			local tbl = {
				position = position or Vector2.Zero,
				size = size or Vector2.Zero
			}
			setmetatable(tbl, Rectangle.meta)
			return tbl
		end
	}
}
setmetatable(Rectangle, Rectangle.meta)
Circle = {
	meta = {
		__name = "Circle",
		__call = function(_, position, radius)
			local tbl = {
				position = position or Vector2.Zero,
				radius = radius or 0
			}
			setmetatable(tbl, Circle.meta)
			return tbl
		end
	}
}
setmetatable(Circle, Circle.meta)
Triangle = {
	meta = {
		__name = "Triangle",
		__call = function(_, firstPoint, secondPoint, thirdPoint)
			local tbl = {
				firstPoint = firstPoint or Vector2.Zero,
				secondPoint = secondPoint or Vector2.Zero,
				thirdPoint = thirdPoint or Vector2.Zero
			}
			setmetatable(tbl, Triangle.meta)
			return tbl
		end
	}
}
setmetatable(Triangle, Triangle.meta)
Cube = {
	meta = {
		__name = "Cube",
		__call = function(_, position, size)
			position = position or Vector3.Zero
			size = size or 0
			local tbl = {
				position = position,
				size = size
			}
			setmetatable(tbl, Cube.meta)
			return tbl
		end
	}
}
setmetatable(Cube, Cube.meta)
Box = {
	meta = {
		__name = "Box",
		__call = function(_, position, size)
			position = position or Vector3.Zero
			size = Vector3.Zero
			local tbl = {
				position = position,
				size = size
			}
			setmetatable(tbl, Box.meta)
			return tbl
		end
	}
}
setmetatable(Box, Box.meta)
Sphere = {
	meta = {
		__name = "Sphere",
		__call = function(_, position, diameter)
			position = position or Vector3.Zero
			diameter = diameter or 0
			local tbl = {
				position = position,
				diameter = diameter
			}
			setmetatable(tbl, Sphere.meta)
			return tbl
		end
	}
}
setmetatable(Sphere, Sphere.meta)
Cylinder = {
	meta = {
		__name = "Cylinder",
		__call = function(_, position, diameter, height)
			position = position or Vector3.Zero
			diameter = diameter or 0
			height = height or 0
			local tbl = {
				position = position,
				diameter = diameter,
				height = height
			}
			setmetatable(tbl, Cylinder.meta)
			return tbl
		end
	}
}
setmetatable(Cylinder, Cylinder.meta)
Triangle3D = {
	meta = {
		__name = "Triangle3D",
		__call = function(_, firstPoint, secondPoint, thirdPoint)
			firstPoint = firstPoint or Vector3.Zero
			secondPoint = secondPoint or Vector3.Zero
			thirdPoint = thirdPoint or Vector3.Zero
			local tbl = {
				firstPoint = firstPoint or Vector3.Zero,
				secondPoint = secondPoint or Vector3.Zero,
				thirdPoint = thirdPoint or Vector3.Zero
			}
			setmetatable(tbl, Triangle3D.meta)
			return tbl
		end
	}
}
setmetatable(Triangle3D, Triangle3D.meta)
Draw = { }
Mouse = { }
Texture = {
	Filter = {
		Point = 0,
		Bilinear = 1,
		Trilinear = 2,
		Anisotropic4X = 3,
		Anisotropic8X = 4,
		Anisotropic16X = 5
	},
	Wrap = {
		Repeat = 0,
		Clamp = 1,
		MirrorRepeat = 2,
		MirrorClamp = 3
	}
}
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
			Right = 93
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
			Right = 344
		},
		Control = {
			Left = 341,
			Right = 345
		},
		Alt = {
			Left = 342,
			Right = 346
		},
		Super = {
			Left = 343,
			Right = 347
		},
		KBMenu = 348,
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
			Equal = 336
		},
		Button = {
			Back = 4,
			Menu = 5,
			VolumeUp = 24,
			VolumeDown = 25
		}
	}
}
Audio = { }
Config = {
	Window = {
		size = Vector2(640, 480),
		title = "YueCat",
		Flags = {
			msaa = false,
			borderless = false,
			topmost = false,
			resizable = false,
			vsync = false
		}
	},
	Audio = {
		active = true
	}
}
Camera3D = {
	meta = {
		__name = "Camera3D",
		__call = function(_, position, target, up, fov, projection)
			position = position or Vector2.Zero
			target = target or Vector2.Zero
			up = up or Vector2.Zero
			fov = fov or 45
			projection = projection or Camera3D.Projection.Perspective
			local tbl = {
				position = position,
				target = target,
				up = up,
				fov = fov,
				projection = projection
			}
			setmetatable(tbl, Camera3D.meta)
			return tbl
		end
	},
	Projection = {
		Perspective = 0,
		Orthographic = 1
	}
}
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
			Right = 14
		},
		Misc1 = 15,
		Paddle1 = 16,
		Paddle2 = 17,
		Paddle3 = 18,
		Paddle4 = 19,
		Touchpad = 20
	},
	Axis = {
		Invalid = -1,
		Left = {
			x = 0,
			y = 1
		},
		Right = {
			x = 2,
			y = 3
		},
		Trigger = {
			Left = 4,
			Right = 5
		}
	},
	Vector = {
		DPad = 0,
		Left = 1,
		Right = 2
	},
	Connected = function(controller) end,
	Disconnected = function(index) end
}
Window = { }
Cursor = { }
table.randomkey = function(tbl)
	local keys = { }
	for k, _ in pairs(tbl) do
		table.insert(keys, k)
	end
	return keys[math.random(#keys)]
end
table.random = function(tbl)
	return tbl[table.randomkey(tbl)]
end
table.length = function(tbl)
	local count = 0
	for _, _ in pairs(tbl) do
		count = count + 1
	end
	return count
end
Time = {
	meta = {
		__name = "Time",
		__call = function(_, nsec)
			nsec = nsec or 0
			local tbl = {
				nsec = nsec
			}
			return tbl
		end
	}
}
Vector2.DistanceAngle = function(distance, angle)
	return Vector2(distance * math.cos(-(angle - (math.pi * .5))), distance * -math.sin(-(angle - (math.pi * .5))))
end
Font = { }
Monitor = { }
math.stween = function(value, goal, smoothness)
	return value + (goal - value) * smoothness
end
Music = { }
RenderTexture = { }
Sound = { }
Spline = { }
Image = {
	Draw = { }
}
