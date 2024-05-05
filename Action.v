import gg

enum Actions {
	no
	quit
	dim_center_p0
	aug_center_p0
	change_sens_p0
	dim_center_p1
	aug_center_p1
	change_sens_p1
	aug_p_nb
	dim_p_nb
	start
}

fn (mut app App) list_imput_action_init(){
	// 348
	app.list_imput_action = []Actions{len: 348, init: Actions.no}
	app.list_imput_action[int(gg.KeyCode.escape)] = Actions.quit

	app.list_imput_action[int(gg.KeyCode.s)] = Actions.dim_center_p0
	app.list_imput_action[int(gg.KeyCode.d)] = Actions.aug_center_p0
	app.list_imput_action[int(gg.KeyCode.f)] = Actions.change_sens_p0

	app.list_imput_action[int(gg.KeyCode.j)] = Actions.dim_center_p1
	app.list_imput_action[int(gg.KeyCode.k)] = Actions.aug_center_p1
	app.list_imput_action[int(gg.KeyCode.l)] = Actions.change_sens_p1

	app.list_imput_action[int(gg.KeyCode.t)] = Actions.dim_p_nb
	app.list_imput_action[int(gg.KeyCode.y)] = Actions.aug_p_nb

	app.list_imput_action[int(gg.KeyCode.space)] = Actions.start
}

fn (mut app App) imput(index int){
	if app.imput_action_change == Actions.no{
		app.imput_action(index)
	}
	else{
		app.list_imput_action[index] = app.imput_action_change
		app.imput_action_change = Actions.no
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
		else{}
	}
	
}
