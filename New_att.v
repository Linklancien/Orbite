import rand

fn (mut app App) new_att(){
	match rand.int_in_range(0, 50) or{0}{
		1{
			mut count := 0
			for attaque in app.attaques{
				if attaque.is_orbite{
					count += 1
					if count + 1 < app.center_list.len {
						break
					}
				}
			}
			if count + 1 < app.center_list.len {
				app.attaques  << Orbs_annil{true, [rand.int_in_range(0, app.center_list.len) or {0}], 200, 50}
			}
		}
		2{
			mut x := 0.0
			mut y := 0.0
			match rand.int_in_range(1, 4) or{0} {
				1{
					x = rand.f64_in_range(0, app.win_width)	or{0}
				}
				2{
					x = rand.f64_in_range(0, app.win_width)	or{0}
					y = app.win_height
				}
				3{
					y = rand.f64_in_range(0, app.win_height)	or{0}
				}
				4{
					y = rand.f64_in_range(0, app.win_height)	or{0}
					x = app.win_width
				}
				else{}
			}

			pos := Vector{x, y, 0}
			radius := rand.f64_in_range(10, 50)	or{0}
			mut list_p := []int{}
			for p_ind in 0..app.players_list.len{
				if app.players_list[p_ind].is_alive{
					list_p << p_ind
				}
			}
			p_cible := list_p[rand.int_in_range(0, list_p.len-1) or {0}]

			norm := mult(100, (app.players_list[p_cible].pos - pos).normalize())

			app.attaques  << Meteor{false, norm, radius, pos,  200, 500}
		}
		else{}
	}
}