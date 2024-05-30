import gx
import gg 

interface Attaques {
	render(app App)
	check(app App, p Player) bool
	name Attaques_name

	mut:
		cooldown	int
		time		int
		update(mut app App)
}

enum Attaques_name {
	@none		=	0
	orbs_annil	= 	1
	meteor		=	2
	laser		=	3
	missile		=	4
}

// Orbs annil
struct Orbs_annil{
	name	Attaques_name 
	orbs		[]int
	mut:
		cooldown	int
		time		int
	// name	orbs	cooldown	time
}

fn (mut ann Orbs_annil) update(mut app App){
	if ann.cooldown > 0{
		ann.cooldown -= 1
	}
	else if ann.time > 0{
		ann.time -= 1
	}
}

fn (ann Orbs_annil) render(app App){
	mut color := gx.gray
	if ann.cooldown == 0{
		color = gx.red
	}
	else if ann.cooldown %20 < 10{
		color = gx.Color{255, 255, 255, 150}
	}

	for orb in ann.orbs{
		app.center_list[orb].render(app, color)
	}
}

fn (ann Orbs_annil) check(app App, p Player) bool{
	if ann.cooldown == 0{
		for at in ann.orbs{
			if p.center == at {
				return true
			}
		}
	}
	return false
}

// Meteor
struct Meteor{
	name	Attaques_name
	norm		Vector
	radius		f64
	
	mut:
		pos		Vector
		cooldown	int
		time		int
	//name	norm	radius	pos	cooldown	time
}

fn (mut met Meteor) update(mut app App){
	if met.cooldown > 0{
		met.cooldown -= 1
	}
	else if met.time > 0{
		met.pos = met.pos + mult(time, met.norm)
		if met.pos.x < 0 || met.pos.y < 0 || app.win_width < met.pos.x || app.win_height < met.pos.y{
			met.time = 0
		}
	}
}

fn (met Meteor) render(app App){
	if  met.cooldown > 0{
		mut color := gx.gray
		if met.cooldown %20 -10 < 0{
			color = gx.white
		}

		pos :=	met.pos + mult(1, met.norm)
		pos1 :=	pos + Vector{0, -40, 0}
		pos2 :=	pos + Vector{-40, 40, 0}
		pos3 :=	pos + Vector{40, 40, 0}
		app.gg.draw_triangle_filled(f32(pos1.x), f32(pos1.y), f32(pos2.x), f32(pos2.y), f32(pos3.x), f32(pos3.y), gx.red)

		pos_line 		:= pos + Vector{0, -20, 0}
		pos_line_bot	:= pos + Vector{0, 15, 0}
		x1 := f32(pos_line.x)
		y1 := f32(pos_line.y)
		x2 := f32(pos_line_bot.x)
		y2 := f32(pos_line_bot.y)
		config := gg.PenConfig {color, .solid, 5}
		app.gg.draw_line_with_config(x1, y1, x2, y2, config)
		app.gg.draw_line_with_config(x2, y2, x1, y1, config)

		pos_circle	:= pos + Vector{0, 25, 0}
		app.gg.draw_circle_filled(f32(pos_circle.x), f32(pos_circle.y), 5, color)
	}
	else{
		app.gg.draw_circle_filled(f32(met.pos.x), f32(met.pos.y), f32(met.radius), gx.red)
	}
}

fn (met Meteor) check(app App, p Player) bool{
	if met.cooldown == 0{
		if circle_is_in_cirle(met.pos, met.radius, p.pos, player_r){
			return true
		}		
	}
	return false
}

// Laser
struct Laser{
	name Attaques_name
	mut:
		rotation	f64
		temps_tour	f64
		cooldown	int
		time		int
	// name	rotation	temps_tour cooldown	time
}

fn (mut laser Laser) update(mut app App){
	laser.rotation += time/laser.temps_tour
	if laser.cooldown > 0{
		laser.cooldown -= 1
	}
	else if laser.time > 0{
		laser.time -= 1
	}
}

fn (laser Laser) render(app App){
	mut color := gx.gray
	if laser.cooldown == 0{
		color = gx.red
	}
	else if laser.cooldown %20 < 10{
		color = gx.white
	}
	pos := Vector{f32(app.win_width/2), f32(app.win_height/2), 0} + mult(1.2, app.center_list[app.center_list.len-1].dist.turn(laser.rotation))
	x := pos.x
	y := pos.y
	app.gg.draw_line(f32(app.win_width/2), f32(app.win_height/2), f32(x), f32(y), color)
}

fn (laser Laser) check(app App, p Player) bool{
	if laser.cooldown == 0{
		if app.center_list[p.center].dist.turn(p.rotation).point_is_in_cirle(app.center_list[p.center].dist.turn(laser.rotation) ,player_r){
			return true
		}
	}
	return false
}

// Missile
struct Missile{
	name	Attaques_name
	radius	f64
	mut:
		pos			Vector
		cible 		Vector
		direction	Vector
		cooldown	int
		time		int
	// name	radius	pos	cible	direction cooldown	time
}

fn (mut miss Missile) update(mut app App){
	if miss.cooldown > 0{
		miss.cooldown -= 1
	}
	else if miss.time > 0{
		if miss.pos.point_is_in_cube_center(miss.cible, 2){
			miss.time -= 1
		}else{
			miss.pos = miss.pos + mult(10, miss.direction)
		}
	}
}

fn (miss Missile) render(app App){
	mut color := gx.gray
	if miss.cooldown == 0{
		color = gx.red
	}
	else if miss.cooldown %20 < 10{
		color = gx.white
	}
	// Cible
	cible_x := f32(miss.cible.x)
	cible_y := f32(miss.cible.y)
	app.gg.draw_circle_empty(cible_x, cible_y, 10, gx.white)

	// Missile
	app.gg.draw_circle_filled(f32(miss.pos.x), f32(miss.pos.y), f32(miss.radius), color)
}

fn (miss Missile) check(app App, p Player) bool{
	if miss.cooldown == 0{
		if circle_is_in_cirle(miss.pos, miss.radius, p.pos, player_r){
			return true
		}
	}
	return false
}
