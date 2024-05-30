import rand
import math

fn (mut app App) new_att(){
	mut count := 0
	match Attaques_name.from(rand.int_in_range(1, 50) or{0}) or {Attaques_name.@none}{
		// .orbs_annil{
		// 	for attaque in app.attaques{
		// 		if attaque.name == Attaques_name.orbs_annil{
		// 			count += 1
		// 			if count + 1 > app.center_list.len {
		// 				break
		// 			}
		// 		}
		// 	}
		// 	if count + 1 < app.center_list.len {
		// 		// name	orbs	cooldown	time
		// 		app.attaques  << Orbs_annil{Attaques_name.orbs_annil, [rand.int_in_range(0, app.center_list.len) or {0}], 200, 50}	
		// 	}
		// }
		// .meteor{
		// 	nb := int(app.score[0]/10 +1)-app.attaques.len
		// 	x := app.win_width/(1+nb)
		// 	y := app.win_height

		// 	mut direction := 0
		// 	mut cible	:= Vector{0, 0, 0}
		// 	match rand.int_in_range(1, 2) or{0} {
		// 		1{
		// 			direction	= 1
		// 			cible	= Vector{0, -1, 0}
		// 		}
		// 		2{
		// 			direction	= 0
		// 			cible	= Vector{0, 1, 0}
		// 		}
		// 		else{}
		// 	}
		// 	radius := 40

		// 	for num in 0..nb{
		// 		pos		:= Vector{x*(num+1), y*direction, 0}
		// 		norm := mult(100, cible.normalize())

		// 		//name	norm	radius	pos	cooldown	time
		// 		app.attaques  << Meteor{Attaques_name.meteor, norm, radius, pos,  200, 500}
		// 	}
		// }
		.laser{
			for attaque in app.attaques{
				if attaque.name == Attaques_name.laser{
					count += 1
					if count > 1 {
						break
					}
				}
			}
			if count < 1 {
				nb := int(app.score[0]/10 +1) - app.attaques.len

				rota := rand.f64_in_range(0, 2*math.pi) or {0}

				mut sens := rand.int_in_range(0, 1) or {0}
				if sens == 0{
					sens = -1
				}

				temps_tour := 2*f64(sens)*math.pi*app.center_list[0].radius/rand.f64_in_range(200, 400) or {200}
				cooldown := 50
				time_laser := rand.int_in_range(50, 100) or {100}

				for laser_num in 0..nb{
					// name	rotation	temps_tour cooldown	time
					rota_perso := rota + (2*math.pi/f64(nb))*laser_num
					app.attaques  << Laser{Attaques_name.laser, rota_perso, temps_tour, cooldown, time_laser}
				}
			}
		}
		// .missile{
		// 	nb := int(app.score[0]/10 +1)-app.attaques.len

		// 	center := rand.int_in_range(1, app.center_list.len) or {0}

		// 	cooldown := rand.int_in_range(100, 200)	or {100}
		// 	time_missile := rand.int_in_range(100, 200) or {100}

		// 	for _ in 0..nb{
		// 		radius := rand.f64_in_range(10, 40)	or{0}

		// 		mut cible :=(app.center_list[center].dist).turn(rand.f64_in_range(0, math.pi*2) or {0})

		// 		direction := (cible).normalize()

		// 		cible = cible + Vector{app.win_width/2, app.win_height/2, 0}

		// 		// name	radius	pos	cible	direction cooldown	time
		// 		app.attaques  << Missile{Attaques_name.missile, radius, Vector{app.win_width/2, app.win_height/2, 0}, cible, direction, cooldown, time_missile}
		// 	}
		// }
		else{}
	}
}
