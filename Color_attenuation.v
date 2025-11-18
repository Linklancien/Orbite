import gg

fn attenuation(color gg.Color, new_a u8) gg.Color {
	return gg.Color{color.r, color.g, color.b, new_a}
}
