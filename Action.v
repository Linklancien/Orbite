import gg
import gx

const actions_names = ["None", "Quit the game", "Start the game", "Pause", "+ players nbs", "- players nbs", "- center player 0", "+ center player 0", "Change sens player 0", "- center player 1", "+ center player 1", "Change sens player 1", "- center player 3", "+ center player 2", "Change sens player 2", "- center player 3", "+ center player 3", "Change sens player 3"]

enum Actions {
	no				= 0
	quit			= 1
	start			= 2
	pause			= 3

	dim_p_nb		= 4
	aug_p_nb		= 5

	dim_center_p0	= 6
	aug_center_p0	= 7
	change_sens_p0	= 8
	
	dim_center_p1	= 9
	aug_center_p1	= 10
	change_sens_p1	= 11

	dim_center_p2	= 12
	aug_center_p2	= 13
	change_sens_p2	= 14

	dim_center_p3	= 15
	aug_center_p3	= 16
	change_sens_p3	= 17
}

const key_code_name := {
	0	: ""
	32	: "space"
	39	: "apostrophe"
	44	: "comma"	//,
	45	: "minus"	//-
	46	: "period"	//.
	47	: "slash"
	48	: "0"
	49	: "1"
	50	: "2"
	51	: "3"
	52	: "4"
	53	: "5"
	54	: "6"
	55	: "7"
	56	: "8"
	57	: "9"
	59	: "semicolon"	//;
	61	: "equal" 		//:
	65	: "a"
	66	: "b"
	67	: "c"
	68	: "d"
	69	: "e"
	70	: "f"
	71	: "g"
	72 	: "h"
	73	: "i"
	74	: "j"
	75	: "k"
	76	: "l"
	77	: "m"
	78	: "n"
	79	: "o"
	80	: "p"
	81	: "q"
	82	: "r"
	83	: "s"
	84	: "t"
	85	: "u"
	86	: "v"
	87	: "w"
	88	: "x"
	89	: "y"
	90	: "z"
	91	: "left_bracket"	//[
	92	: "backslash"		//\
	93	: "right_bracket"	//]
	96	: "grave_accent"	//`
	161	: "world_1"			// non-us #1
	162 : "world_2"			// non-us #2
	256	: "escape"
	257 : "enter"
	258	: "tab"
	259	: "backspace"
	260	: "insert"
	261	: "delete"
	262	: "right"
	263	: "left"
	264	: "down"
	265	: "up"
	266 : "page_up"
	267	: "page_down"
	268 : "home"
	269	: "end"
	280 : "caps_lock"
	281	: "scroll_lock"
	282	: "num_lock"
	283	: "print_screen"
	284	: "pause"
	290	: "f1"
	291	: "f2"
	292	: "f3"
	293	: "f4"
	294	: "f5"
	295	: "f6"
	296	: "f7"
	297	: "f8"
	298	: "f9"
	299	: "f10"
	300	: "f11"
	301	: "f12"
	302	: "f13"
	303	: "f14"
	304 : "f15"
	305 : "f16"
	306	: "f17"
	307	: "f18"
	308	: "f19"
	309	: "f20"
	310	: "f21"
	311	: "f22"
	312	: "f23"
	313	: "f24"
	314	: "f24"
	320	: "kp_0"
	321	: "kp_1"
	322	: "kp_2"
	323	: "kp_3"
	324	: "kp_4"
	325	: "kp_5"
	326	: "kp_6"
	327	: "kp_7"
	328	: "kp_8"
	329	: "kp_9"
	330	: "kp_decimal"
	331	: "kp_divide"
	332	: "kp_multiply"
	333	: "kp_subtract"
	334	: "kp_add"
	335	: "kp_enter"
	336	: "kp_equal"
	340 : "left_shift"
	341	: "left_control"
	342	: "left_alt"
	343	: "left_super"
	344	: "right_shift"
	345	: "right_control"
	346	: "right_alt"
	347	: "right_super"
	348	: "menu"
}

fn (mut app App) list_imput_action_key_code_init(){
	// 348
	app.list_imput_action = []Actions{len: 348, init: Actions.no}
	app.list_action_key_code = []int{len: actions_names.len, init: 0}

	// Quit
	app.list_imput_action[int(gg.KeyCode.f4)] = Actions.quit

	app.list_action_key_code[Actions.quit] = int(gg.KeyCode.f4)

	// Start
	app.list_imput_action[int(gg.KeyCode.space)] = Actions.start
	app.list_action_key_code[Actions.start] = int(gg.KeyCode.space)

	// Pause
	app.list_imput_action[int(gg.KeyCode.escape)] = Actions.pause
	app.list_action_key_code[Actions.pause] = int(gg.KeyCode.escape)
	///////////////////////////////////////////////////////////////////////////////////////
	
	// Nb players
	app.list_imput_action[int(gg.KeyCode.t)] = Actions.dim_p_nb
	app.list_imput_action[int(gg.KeyCode.y)] = Actions.aug_p_nb

	app.list_action_key_code[Actions.dim_p_nb] = int(gg.KeyCode.t)
	app.list_action_key_code[Actions.aug_p_nb] = int(gg.KeyCode.y)

	// Player 0
	app.list_imput_action[int(gg.KeyCode.s)] = Actions.dim_center_p0
	app.list_imput_action[int(gg.KeyCode.d)] = Actions.aug_center_p0
	app.list_imput_action[int(gg.KeyCode.f)] = Actions.change_sens_p0

	app.list_action_key_code[6] = int(gg.KeyCode.s)
	app.list_action_key_code[7] = int(gg.KeyCode.d)
	app.list_action_key_code[8] = int(gg.KeyCode.f)

	// Player 1
	app.list_imput_action[int(gg.KeyCode.u)] = Actions.dim_center_p1
	app.list_imput_action[int(gg.KeyCode.i)] = Actions.aug_center_p1
	app.list_imput_action[int(gg.KeyCode.o)] = Actions.change_sens_p1

	app.list_action_key_code[9] = int(gg.KeyCode.u)
	app.list_action_key_code[10] = int(gg.KeyCode.i)
	app.list_action_key_code[11] = int(gg.KeyCode.o)

	// Player 2
	app.list_imput_action[int(gg.KeyCode.a)] = Actions.dim_center_p2
	app.list_imput_action[int(gg.KeyCode.z)] = Actions.aug_center_p2
	app.list_imput_action[int(gg.KeyCode.e)] = Actions.change_sens_p2

	app.list_action_key_code[12] = int(gg.KeyCode.a)
	app.list_action_key_code[13] = int(gg.KeyCode.z)
	app.list_action_key_code[14] = int(gg.KeyCode.e)

	// Player 3
	app.list_imput_action[int(gg.KeyCode.w)] = Actions.dim_center_p3
	app.list_imput_action[int(gg.KeyCode.x)] = Actions.aug_center_p3
	app.list_imput_action[int(gg.KeyCode.c)] = Actions.change_sens_p3

	app.list_action_key_code[15] = int(gg.KeyCode.w)
	app.list_action_key_code[16] = int(gg.KeyCode.x)
	app.list_action_key_code[17] = int(gg.KeyCode.c)
}

fn (mut app App) imput(index int){
	if app.imput_action_change == Actions.no{
		app.imput_action(index)
	}
	else{
		// Change old
		// Set the old imput for the changing action to no
		index_old_key	:= app.list_action_key_code[int(app.imput_action_change)]
		app.list_imput_action[index_old_key] = Actions.no
		// Set the old action linked to the imput (index) to 0
		old_action := app.list_imput_action[index]
		app.list_action_key_code[int(old_action)] = 0


		// New
		// Change to match the imput with what action it do
		app.list_imput_action[index] = app.imput_action_change
		// Change to match action to what is the imput that triger it
		app.list_action_key_code[int(app.imput_action_change)] = index

		// Reset imput_action_change
		app.imput_action_change = Actions.no
	}
}

fn (mut app App) settings_render(){
	for ind in 1..10{
		if ind + app.pause_scroll < actions_names.len {
			x := int(app.win_width/2)
			y := int(100 + ind * 40)
			app.text_rect_render(x, y, (actions_names[ind + app.pause_scroll] + ": " + key_code_name[app.list_action_key_code[ind + app.pause_scroll]]))

			x2 := int(3*app.win_width/4)
			app.gg.draw_circle_filled(x2, y + 15, boutons_radius, gx.gray)
		}
	}
}

fn (mut app App) imput_action(index int){
	match app.list_imput_action[index]{
		.quit {
			app.gg.quit()
		}
		.dim_center_p0 {
			if app.game{
				if app.players_list[0].center > 0 && app.game{
					app.players_list[0].center_changer(-1 ,app)
				}
			}
		}
		.aug_center_p0  {
			if app.game{
				if app.players_list[0].center < app.center_list.len -1{
					app.players_list[0].center_changer(1 ,app)
				}
			}
		}
		.change_sens_p0 {
			if app.game{
				app.players_list[0].temps_tour = -app.players_list[0].temps_tour
			}
			
		}
		.dim_center_p1 {
			if app.player_nb > 1 && app.game{
				if app.players_list[1].center > 0{
					app.players_list[1].center_changer(-1 ,app)
				}
			}	
		}
		.aug_center_p1 {
			if app.player_nb > 1 && app.game{
				if app.players_list[1].center < app.center_list.len -1{
					app.players_list[1].center_changer(1 ,app)
				}
			}
		}
		.change_sens_p1 {
			if app.player_nb > 1 && app.game{
				app.players_list[1].temps_tour = -app.players_list[1].temps_tour
			}
		}
		.aug_p_nb {
			if app.player_nb < nb_player_max && !app.game{
				app.player_nb += 1
			}
		}
		.dim_p_nb {
			if app.player_nb > 1 && !app.game{
				app.player_nb -= 1
			}					
		}
		.start {
			if !app.game{
				app.game_start()
			}
		}
		.pause{
			app.pause_scroll = 0
			app.pause = !app.pause
		}
		else{}
	}
	
}
