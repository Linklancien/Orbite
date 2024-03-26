import gx

interface Attaques {
	render(app App)
	check(p Player) bool

	mut:
		cooldown	int
		update(app App)
	
	
}

struct Orbs_annil{
	orbs		[]int
	mut:
		cooldown	int
		time		int
}

fn (mut ann Orbs_annil) update(app App){
	if ann.cooldown > 0{
		ann.cooldown -= 1
	}
	else if ann.time > 0{
		ann.time -= 1
	}
	else{
		println("END Attaque")
	}
}

fn (ann Orbs_annil) render(app App){
	mut color := gx.red
	if ann.cooldown %2 == 1{
		color = gx.white
	}

	for orb in ann.orbs{
		app.at_pt_list[orb].render(app, color)
	}
}

fn (ann Orbs_annil) check(p Player) bool{
	if ann.time != 0{
		for at in ann.orbs{
			if p.center == at {
				return true
			}
		}
	}
	return false
}

