module main

import math

struct Vector {
	mut:
		x f64
		y f64
		z f64
}

// FONCTIONS POUR LES VECTEURS
@[inline]
fn (vec Vector) normalize() Vector {
	len := vec.len()
	if len == 0 {
		return Vector{0, 0, 0}
	}
	return Vector{
		x: vec.x / len
		y: vec.y / len
		z: vec.z / len
	}
}

@[inline]
fn (vec Vector) square_len() f64 {
	return vec.x * vec.x + vec.y * vec.y + vec.z * vec.z
}

@[inline]
fn (vec Vector) len() f64 {
	return math.sqrt(vec.square_len())
}

fn (vec Vector) abs() Vector {
	return Vector{math.abs(vec.x), math.abs(vec.y), math.abs(vec.z)}
}

fn mult(val f64, vec Vector) Vector {
	return Vector{val * vec.x, val * vec.y, val * vec.z}
}

// produit scalaire (dot product)
fn dot(vec1 Vector, vec2 Vector) f64 { 
	return vec1.x * vec2.x + vec1.y * vec2.y + vec1.z * vec2.z
}

// Produit Vectoriel
fn prod_vec(vec1 Vector, vec2 Vector) Vector { 
	new_x := vec1.y * vec2.z - vec1.z * vec2.y
	new_y := vec1.z * vec2.x - vec1.x * vec2.z
	new_z := vec1.x * vec2.y - vec1.y * vec2.x
	return Vector{new_x, new_y, new_z}
}

fn rdot_f(vec1 Vector, vec2 Vector) f64 {
	return f64(vec1.x) / f64(vec2.x) + f64(vec1.y) / f64(vec2.y) + f64(vec1.z) / f64(vec2.z)
}

fn divi_v(vec1 Vector, vec2 Vector) Vector {
	return Vector{vec1.x / vec2.x, vec1.y / vec2.y, vec1.z / vec2.z}
}

fn (vec Vector) turn(angle f64) Vector {
	cos := math.cos(angle)
	sin := math.sin(angle)
	return mult(vec.x, Vector{cos, sin, 0}) + mult(vec.y, Vector{-sin, cos, 0}) + Vector{0, 0, vec.z}
}

fn (vec1 Vector) + (vec2 Vector) Vector {
	return Vector{vec1.x + vec2.x, vec1.y + vec2.y, vec1.z + vec2.z}
}

@[inline]
fn (vec1 Vector) - (vec2 Vector) Vector {
	return Vector{vec1.x - vec2.x, vec1.y - vec2.y, vec1.z - vec2.z}
}

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
