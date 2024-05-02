const boutons_radius := 10
const text_boutons := ["-", "+"]

fn (mut app App) check_boutons(x_mouse f32, y_mouse f32){
	mouse_pos := Vector{f64(x_mouse), f64(y_mouse), 0}
	mut circle_pos := app.bouton_list[0]
	// Sup Player
	if mouse_pos.point_is_in_cirle(circle_pos, boutons_radius){
		if app.player_nb > 1 && !app.game{
			app.player_nb -= 1
		}
	}
	// Ad player
	circle_pos = app.bouton_list[1]
	if mouse_pos.point_is_in_cirle(circle_pos, boutons_radius){
		if app.player_nb < nb_player_max && !app.game{
			app.player_nb += 1
		}
	}
}