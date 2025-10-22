package LuaCat

clamp_255 :: proc(val: $T) -> T {
	return clamp(val, 0, 255)
}

scalar_to_u8 :: proc(scalar: f32) -> u8 {
	return u8(clamp_255(scalar * 255))
}