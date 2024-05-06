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

fn (mut app App) list_imput_action_key_code_init(){
	// 348
	app.list_imput_action = []Actions{len: 348, init: Actions.no}
	app.list_key_code_action = []int{len: actions_names.len, init: 0}

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
	for ind in 0..10{
		if ind < actions_names.len - 1 {
			x := int(app.win_width/2)
			y := int(100 + ind * 40)
			app.text_rect_render(x, y, actions_names[ind])
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
