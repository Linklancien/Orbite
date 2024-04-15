fn point_is_in_cube(is_in_min Vector, is_in_max Vector, in_min Vector, in_max Vector) bool{
	is_min_x := in_min.x < is_in_max.x
	is_min_y := in_min.y < is_in_max.y
	is_min_z := in_min.z < is_in_max.z

	is_max_x := in_max.x > is_in_min.x
	is_max_y := in_max.y > is_in_min.y
	is_max_z := in_max.z > is_in_min.z
	if is_min_x && is_max_x && is_min_y && is_max_y && is_min_z && is_max_z {
		return true
	}
	else {
		return false
	}
}

fn (vec Vector) point_is_in_cube_center(cube_center Vector, arrete f64) bool{
	comb_vec := cube_center - vec
	arrete_square := (arrete/2.0)*(arrete/2.0)
	x := comb_vec.x * comb_vec.x
	y := comb_vec.y * comb_vec.y
	z := comb_vec.z * comb_vec.z

	if x <= arrete_square && y <= arrete_square && z <= arrete_square {
		return true
	}
	else {
		return false
	}
}

fn (vec Vector) point_is_in_cirle(center Vector, radius f64) bool{
	comb_vec := vec - center
	radius_square := radius*radius
	
	if comb_vec.square_len() < radius_square{
		return true
	}
	else {
		return false
	}
}
