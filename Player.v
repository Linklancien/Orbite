import gg
import gx

const player_r = 10
const time		= 1.0/8.0

struct Player{
	mut:
		pos 		Vector
		rotation	f64
		moment		f64
		center 		int
	color			gx.Color
}

fn (p Player) render(app App){
	app.gg.draw_circle_filled(f32(p.pos.x), f32(p.pos.y), player_r, p.color)
}

fn (mut p Player) update(app App){
	p.rotation += p.moment*time
	center := app.at_pt_list[p.center]
	p.pos = center.pos + center.dist.turn(p.rotation)
}


struct Attrac_point{
	mut:
		pos Vector
		dist Vector
}