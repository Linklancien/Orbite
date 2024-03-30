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

	game		bool
	
	win_width	f64
	win_height	f64
	text_cfg	gx.TextCfg

	players_list	[]Player
	player_nb		int
	center_list		[]Center

	attaques			[]Attaques

	score	[]int
}

fn main() {

	mut app := &App{}
	app.gg = gg.new_context(
		fullscreen: false
		width: 700
		height: 700
		create_window: true
		window_title: '- Orbites -'
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
	app.player_nb = 1
	app.game = false
	app.gg.begin()

	app.score = [0]

	size := app.gg.window_size()
	app.win_width 		= size.width
	app.win_height 		= size.height

	app.text_cfg = gx.TextCfg{gx.black, 16, .left, .top, 100, "", false, false, false}

	app.gg.end()
}

fn on_frame(mut app App){
	if app.game{
		if app.attaques.len < int(app.score[0]/10 +1){
			app.new_att()
		}

		for mut p in app.players_list{
			p.update(app)
		}
		for mut att in app.attaques{
			att.update(mut app)
		}

		app. delt_att()
		app.check_death()

		app.gg.begin()
		
		for center in app.center_list{
			center.render(app, gx.green)
		}
		for p in app.players_list{
			p.render(app)
		}
		for att in app.attaques{
			att.render(app)
		}
		
		app.gg.draw_rounded_rect_filled(int(app.win_width/2), 15, 60, 25, 5, gx.gray)
		app.gg.draw_text(int(app.win_width/2), 20, "Score: ${app.score[0]}", app.text_cfg)
    	
		
		app.gg.end()
	}
	else{
		app.gg.begin()

		app.gg.draw_rounded_rect_filled(int(app.win_width/2) - 5, int(app.win_height/2), 75, 25, 5, gx.gray)
		app.gg.draw_text(int(app.win_width/2), int(app.win_height/2) + 5, "Score: ${app.score[0]}", app.text_cfg)

		app.gg.draw_rounded_rect_filled(int(app.win_width/2) - 15, int(app.win_height/2) - 40, 90, 25, 5, gx.gray)
		app.gg.draw_text(int(app.win_width/2) - 10, int(app.win_height/2) - 35, "Playernb: ${app.player_nb}", app.text_cfg)

		app.gg.draw_rounded_rect_filled(int(app.win_width/2) - 25, int(app.win_height/2) + 40, 110, 25, 5, gx.gray)
		app.gg.draw_text(int(app.win_width/2) - 20, int(app.win_height/2) + 45, "PRESS SPACE", app.text_cfg)

		app.gg.end()
	}
}

fn on_event(e &gg.Event, mut app App) {
	match e.typ {
		.key_down {
			match e.key_code {
				.escape {
					app.gg.quit()
				}
				.d {
					if app.players_list[0].center > 0{
						app.players_list[0].center_changer(-1 ,app)
					}
				}
				.s {
					if app.players_list[0].center < app.center_list.len -1{
						app.players_list[0].center_changer(1 ,app)
					}
				}
				.f {
					app.players_list[0].temps_tour = -app.players_list[0].temps_tour
				}
				.j {
					if app.player_nb > 1{
						if app.players_list[1].center > 0{
							app.players_list[1].center_changer(-1 ,app)
						}
					}	
				}
				.k {
					if app.player_nb > 1{
						if app.players_list[1].center < app.center_list.len -1{
							app.players_list[1].center_changer(1 ,app)
						}
					}
					
				}
				.l {
					if app.player_nb > 1{
						app.players_list[1].temps_tour = -app.players_list[0].temps_tour
					}
				}
				.t {
					if !app.game{
						app.player_nb += 1
					}
				}
				.y {
					if app.player_nb > 1 && !app.game{
						app.player_nb -= 1
					}					
				}
				.space {
					if !app.game{
						app.game_start()
					}
				}
				else {}
			}
		}
		else{}
	}
}
