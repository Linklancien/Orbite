module main

import gg
import gx

const bg_color = gx.black
const nb_player_max = 4

//______________UI______________
const colors = [gx.red, gx.blue]


const scale = 1

const chunk_size = 20.0 // doit être 2*le radius du plus grand
const div_chunk_size = 1/f64(chunk_size)

struct App {
mut:
	gg &gg.Context = unsafe { nil }

	// Caracteristiques window
	win_width	f64
	win_height	f64

	// UI
	// Police
	text_cfg	gx.TextCfg
	bouton_cfg	gx.TextCfg
	// Boutons
	bouton_list 	[]Vector

	// Pause
	pause			bool
	pause_scroll	int

	// Is game running
	game			bool
	death_screen_time int	// Delay to see what kill you
	
	// imput_action
	list_imput_action		[]Actions
	list_action_key_code	[]int
	imput_action_change		Actions

	// Mouse position
	mouse_x		f32
	mouse_y		f32

	// Player
	player_nb		int
	players_list	[]Player
	center_list		[]Center
	score			[]int

	// Attaques
	attaques		[]Attaques
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
		.mouse_scroll {
            e.scroll_y{
				if e.scroll_y > 0 && app.pause_scroll > 0{
					app.pause_scroll -= 1
					
				}
				else if e.scroll_y < 0 && app.pause_scroll < actions_names.len - 10{
					app.pause_scroll += 1
				}
			}
        }
		else{}
	}
}
