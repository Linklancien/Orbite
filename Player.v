import gx
import math

const player_r	= 10
const time		= 1.0/20.0

struct Player{
	mut:
		pos 		Vector
		rotation	f64
		temps_tour	f64
		center 		int
		is_alive	bool
	color			gx.Color
}

fn (p Player) render(app App, transparence u8){
	app.gg.draw_circle_filled(f32(p.pos.x), f32(p.pos.y), player_r, attenuation(p.color, transparence))
}

fn (mut p Player) update(app App){
	if p.is_alive{
		p.rotation += time/p.temps_tour
		center := app.center_list[p.center]
		p.pos = center.pos + center.dist.turn(p.rotation)
	}
}

fn (mut p Player) center_changer(change f64, app App){
	p.center = int(p.center + change)
	mut signe := 1.0
	if p.temps_tour < 0{
		signe = -1.0
	}
	p.temps_tour = 2*signe*math.pi*app.center_list[p.center].radius/1000
}


struct Center{
	mut:
		pos		Vector
		dist	Vector
		radius	f64
}

fn (center Center) render(app App, color gx.Color){
	app.gg.draw_circle_empty(f32(center.pos.x), f32(center.pos.y), f32(center.dist.len()), color)
}