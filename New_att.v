import rand
import math

fn (mut app App) new_att(){
	mut count := 0
	match rand.int_in_range(0, 50) or{0}{
		1{
			for attaque in app.attaques{
				if attaque.name == Attaques_name.orbs_annil{
					count += 1
					if count + 1 > app.center_list.len {
						break
					}
				}
			}
			if count + 1 < app.center_list.len {
				// name	orbs	cooldown	time
				app.attaques  << Orbs_annil{Attaques_name.orbs_annil, [rand.int_in_range(0, app.center_list.len) or {0}], 200, 50}	
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

			//name	norm	radius	pos	cooldown	time
			app.attaques  << Meteor{Attaques_name.meteor, norm, radius, pos,  200, 500}
		}
		3{
			for attaque in app.attaques{
				if attaque.name == Attaques_name.laser{
					count += 1
					if count > 1 {
						break
					}
				}
			}
			if count + 1 < 1 {
				nb := rand.int_in_range(1, (int(app.score[0]/10 +1)-app.attaques.len)) or{1}

				// name	rotation	temps_tour cooldown	time
				rota := rand.f64_in_range(0, 2*math.pi) or {0}
				temps_tour := 2*math.pi*app.center_list[0].radius/rand.f64_in_range(150, 400) or {100}
				cooldown := rand.int_in_range(100, 200) or {100}
				time_laser := rand.int_in_range(400, 800) or {100}

				for laser_num in 0..nb{
					app.attaques  << Laser{Attaques_name.laser, rota+(math.pi/2)*laser_num, temps_tour, cooldown, time_laser}
				}
			}
		}
		else{}
	}
}