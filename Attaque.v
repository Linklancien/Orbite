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
	pos		Vector
	norm	Vector
	radius	f64

	mut:
		cooldown	int
		time		int
}

fn (mut met Meteor) update(mut app App){
	if met.cooldown > 0{
		met.cooldown -= 1
	}
	else if met.time > 0{
		met.pos = met.pos + mult(time, met.norm)
		met.time -= 1
	}
}

fn (met Meteor) render(app App){
	app.gg.draw_circle_filled(met.x, met.y, met.radius, gx.red)
}

fn (met Meteor) check(p Player) bool{
	if ann.cooldown == 0{
		if met.x - met.radius < p.pos.x && p.pos.x < met.x + met.radius{
			if met.y - met.radius < p.pos.y && p.pos.y < met.y + met.radius{
				return true
			}
		}		
	}
	return false
}


