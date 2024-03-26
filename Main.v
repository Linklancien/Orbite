module main

import gg
import gx


const bg_color = gx.black

//______________UI______________
const colors = [gx.red, gx.blue]

//____________Physic____________
const gravity = Vector{0, 1, 0}

const materials = {
	'iron':    1.5
	'wood':    1.0
	'feather': 0.5
}

const scale = 1

const chunk_size = 20.0 // doit être 2*le radius du plus grand
const div_chunk_size = 1/f64(chunk_size)

struct App {
mut:
	gg &gg.Context = unsafe { nil }
	
	win_width	f64
	win_height	f64

	players_list	[]Player
	at_pt_list		[]Attrac_point
}

fn main() {
	mut app := &App{}
	app.gg = gg.new_context(
		fullscreen: true
		create_window: true
		window_title: '- Physic -'
		user_data: app
		bg_color: bg_color
		init_fn:  on_init
		frame_fn: on_frame
		event_fn: on_event
		sample_count: 4
	)
	app.gg.run()
}

fn on_init(mut app App) {
	app.gg.begin()

	size := app.gg.window_size()
	app.win_width 		= size.width
	app.win_height 		= size.height

	app.gg.end()
	app.at_pt_list << Attrac_point{Vector{size.width/2, size.height/2, 0}, Vector{0, 100, 0}}
	app.players_list << Player{Vector{0, 0, 0}, 1, 1, 0, gx.red}
}

fn on_frame(mut app App){
	for mut p in app.players_list{
		p.update(app)
	}

	app.gg.begin()
	for p in app.players_list{
		p.render(app)
	}
	app.gg.end()
}

fn on_event(e &gg.Event, mut app App) {
	match e.typ {
		.key_down {
			match e.key_code {
				.escape {
					app.gg.quit()
				}
				// .right_arrow {
				// 	app.gg.quit()
				// }
				// .left_arrow {
				// 	app.gg.quit()
				// }
				else {}
			}
		}
		else{}
	}
}
