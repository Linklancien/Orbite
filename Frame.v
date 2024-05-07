import gx

const pos_x = [-200, 200]

fn on_frame(mut app App){
	if app.pause{
		app.gg.begin()
		app.settings_render()
		app.gg.end()
	}
	else{	
		if app.death_screen_time != 0{
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
			}
			else{
				app.death_screen_time -= 1
			}
			
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
			app.lobby()
		}
	}
}

fn (app App) lobby(){
	app.gg.begin()

	app.text_rect_render(int(app.win_width/2), int(app.win_height/2), "Score: ${app.score[0]}")

	app.text_rect_render(int(app.win_width/2), int(app.win_height/2) - 40, "Players nb: ${app.player_nb}")

	for ind, circle_pos in app.bouton_list{
		x := int(circle_pos.x)
		y := int(circle_pos.y)
		app.gg.draw_circle_filled(x, y, boutons_radius, gx.gray)
		app.gg.draw_text(x, y, text_boutons[ind], app.bouton_cfg)
	}


	app.text_rect_render(int(app.win_width/2), int(app.win_height/2) + 40, "Press " + key_code_name[app.list_action_key_code[Actions.start]])
	mut y := 0
	if app.player_nb <= 2{
		y = int(app.win_height/2)
	}
	else{
		y = int(app.win_height/3)
	}

	for p_nb in 0..app.player_nb{
		x := int(app.win_width/2) + pos_x[p_nb%2]
		mut new_y := y
		if p_nb > 1{
			new_y *= 2
		}

		str := key_code_name[app.list_action_key_code[6+3*p_nb]] + " " + key_code_name[app.list_action_key_code[7+3*p_nb]] + " " + key_code_name[app.list_action_key_code[8+3*p_nb]]

		app.text_rect_render(x, new_y, str)
		app.gg.draw_circle_filled(x, new_y - 40, 10, color_player[p_nb])
	}

	// app.gg.draw_circle_filled(f32(app.win_width/2), f32(app.win_height/2), 10, gx.blue)

	app.gg.end()
}

fn (app App) text_rect_render(x int, y int, text string){
	lenght := text.len * app.text_cfg.size/2
	new_x := x - lenght/2
	new_y := y
	app.gg.draw_rounded_rect_filled(new_x - 5, new_y, lenght, 25, 5, gx.gray)
	app.gg.draw_text(new_x, new_y + 5, text, app.text_cfg)
}