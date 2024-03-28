import gx

interface Attaques {
	render(app App)
	check(p Player) bool

	mut:
		cooldown	int
		time		int
		update(mut app App)
	
	
}

struct Orbs_annil{
	orbs		[]int
	mut:
		cooldown	int
		time		int
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
	else if ann.cooldown %20 -10 < 0{
		color = gx.white
	}

	for orb in ann.orbs{
		app.at_pt_list[orb].render(app, color)
	}
}

fn (ann Orbs_annil) check(p Player) bool{
	if ann.cooldown == 0{
		for at in ann.orbs{
			if p.center == at {
				return true
			}
		}
	}
	return false
}

struct Meteor{
	norm	Vector
	radius	f64

	mut:
		pos		Vector
		cooldown	int
		time		int
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
		pos1 :=	pos + Vector{0, -35, 0}
		pos2 :=	pos + Vector{-35, 35, 0}
		pos3 :=	pos + Vector{35, 35, 0}
		app.gg.draw_triangle_filled(f32(pos1.x), f32(pos1.y), f32(pos2.x), f32(pos2.y), f32(pos3.x), f32(pos3.y), gx.red)

		pos_line 		:= pos + Vector{0, -20, 0}
		pos_line_bot	:= pos + Vector{0, 20, 0}
		app.gg.draw_line(f32(pos_line.x), f32(pos_line.y), f32(pos_line_bot.x), f32(pos_line_bot.y), color)
		pos_circle	:= pos + Vector{0, 25, 0}
		app.gg.draw_circle_filled(f32(pos_circle.x), f32(pos_circle.y), 10, color)
	}
	else{
		app.gg.draw_circle_filled(f32(met.pos.x), f32(met.pos.y), f32(met.radius), gx.red)
		end := met.pos + met.norm
		app.gg.draw_line(f32(met.pos.x), f32(met.pos.y), f32(end.x), f32(end.y), gx.white)
	}
}

fn (met Meteor) check(p Player) bool{
	if met.cooldown == 0{
		if met.pos.x - met.radius < p.pos.x && p.pos.x < met.pos.x + met.radius{
			if met.pos.y - met.radius < p.pos.y && p.pos.y < met.pos.y + met.radius{
				return true
			}
		}		
	}
	return false
}


