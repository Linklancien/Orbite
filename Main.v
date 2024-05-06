module main

import gg
import gx

const bg_color = gx.black
const nb_player_max = 2

//______________UI______________
const colors = [gx.red, gx.blue]


const scale = 1

const chunk_size = 20.0 // doit être 2*le radius du plus grand
const div_chunk_size = 1/f64(chunk_size)

struct App {
mut:
	gg &gg.Context = unsafe { nil }

	pause			bool
	game			bool
	death_screen_time int

	// imput_action
	list_imput_action	[]Actions
	list_action_key_code	[]int
	imput_action_change	Actions

	mouse_x		f32
	mouse_y		f32
	
	win_width	f64
	win_height	f64
	text_cfg	gx.TextCfg
	bouton_cfg	gx.TextCfg

	players_list	[]Player
	player_nb		int
	center_list		[]Center

	attaques		[]Attaques

	score			[]int
	bouton_list 	[]Vector
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
	
	app.list_imput_action_key_code_init()
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
	app.bouton_cfg = gx.TextCfg{gx.black, 16, .center, .middle, 100, "", false, false, false}

	// BOUTONS
	app.bouton_list << [Vector{app.win_width/2 - 100, app.win_height/2  - 30, 0}, Vector{app.win_width/2 + 100, app.win_height/2  - 30, 0}]

	app.gg.end()
}

fn on_event(e &gg.Event, mut app App) {
	match e.typ {
		.key_down {
			app.imput(int(e.key_code))
		}
		.mouse_down{
			app.mouse_x	= e.mouse_x
			app.mouse_y	= e.mouse_y
			match e.mouse_button {
				.left{
					app.check_boutons()
				}
				else{}
			}
		}
		else{}
	}
}
