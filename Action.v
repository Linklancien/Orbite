import gg

const actions_names = ["None", "Quit the game", "- center player 0", "- center player 0", "+ center player 0", "Change sens player 0", "- center player 1", "+ center player 1", "Change sens player 1", "+ players nbs", "- players nbs", "Start the game", "Pause"]

enum Actions {
	no				= 0
	quit			= 1
	dim_center_p0	= 2
	aug_center_p0	= 3
	change_sens_p0	= 4
	dim_center_p1	= 5
	aug_center_p1	= 6
	change_sens_p1	= 7
	dim_p_nb		= 8
	aug_p_nb		= 9
	start			= 10
	pause			= 11
}

const key_code_name := {
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
	app.list_key_code_action = []int{len: actions_names.len, init: 0}

	// Quit
	app.list_imput_action[int(gg.KeyCode.f4)] = Actions.quit

	app.list_key_code_action[1] = int(gg.KeyCode.f4)

	// Player 0
	app.list_imput_action[int(gg.KeyCode.s)] = Actions.dim_center_p0
	app.list_imput_action[int(gg.KeyCode.d)] = Actions.aug_center_p0
	app.list_imput_action[int(gg.KeyCode.f)] = Actions.change_sens_p0

	app.list_key_code_action[2] = int(gg.KeyCode.s)
	app.list_key_code_action[3] = int(gg.KeyCode.d)
	app.list_key_code_action[4] = int(gg.KeyCode.f)

	// Player 1
	app.list_imput_action[int(gg.KeyCode.u)] = Actions.dim_center_p1
	app.list_imput_action[int(gg.KeyCode.i)] = Actions.aug_center_p1
	app.list_imput_action[int(gg.KeyCode.o)] = Actions.change_sens_p1

	app.list_key_code_action[5] = int(gg.KeyCode.u)
	app.list_key_code_action[6] = int(gg.KeyCode.i)
	app.list_key_code_action[7] = int(gg.KeyCode.o)

	// Nb players
	app.list_imput_action[int(gg.KeyCode.t)] = Actions.dim_p_nb
	app.list_imput_action[int(gg.KeyCode.y)] = Actions.aug_p_nb

	app.list_key_code_action[8] = int(gg.KeyCode.t)
	app.list_key_code_action[9] = int(gg.KeyCode.y)

	// Start
	app.list_imput_action[int(gg.KeyCode.space)] = Actions.start
	app.list_key_code_action[10] = int(gg.KeyCode.space)

	// Pause
	app.list_imput_action[int(gg.KeyCode.escape)] = Actions.pause
	app.list_key_code_action[11] = int(gg.KeyCode.escape)
}

fn (mut app App) imput(index int){
	if app.imput_action_change == Actions.no{
		app.imput_action(index)
	}
	else{
		app.list_imput_action[index] = app.imput_action_change
		app.list_key_code_action[int(app.imput_action_change)] = index
		app.imput_action_change = Actions.no
	}
}

fn (mut app App) settings_render(){
	for ind in 1..10{
		if ind < actions_names.len - 1 {
			x := int(app.win_width/2)
			y := int(100 + ind * 40)
			app.text_rect_render(x, y, (actions_names[ind] + ": " + key_code_name[app.list_key_code_action[ind]]))
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
			app.pause = !app.pause
		}
		else{}
	}
	
}
