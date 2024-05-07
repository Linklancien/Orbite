const boutons_radius := 10
const text_boutons := ["-", "+"]

fn (mut app App) check_boutons(){
	mouse_pos := Vector{f64(app.mouse_x), f64(app.mouse_y), 0}
	mut circle_pos := app.bouton_list[0]
	
	if app.pause{
		// Check
		for ind in 1..10{
			if ind + app.pause_scroll < actions_names.len {
				y := 115 + ind * 40
				circle_pos = Vector{f64(3*app.win_width/4), y, 0}
				if mouse_pos.point_is_in_cirle(circle_pos, boutons_radius){
					app.imput_action_change = unsafe{Actions(ind + app.pause_scroll)}
					break
				}
			}
		}
		

	}
	else if !app.game{
		// Sup Player
		if mouse_pos.point_is_in_cirle(circle_pos, boutons_radius){
			if app.player_nb > 1{
				app.player_nb -= 1
			}
		}
		// Ad player
		circle_pos = app.bouton_list[1]
		if mouse_pos.point_is_in_cirle(circle_pos, boutons_radius){
			if app.player_nb < nb_player_max{
				app.player_nb += 1
			}
		}
	}
}