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
			mut max_score := app.score[0]
			for i in app.score {
				if i > max_score {
					max_score = i
				}
			}
			nb := int(max_score/10 +1)-app.attaques.len
			x := app.win_width/(1+nb)
			y := app.win_height

			mut direction := 0
			mut cible	:= Vector{0, 0, 0}
			match rand.int_in_range(1, 2) or{0} {
				1{
					direction	= 1
					cible	= Vector{0, -1, 0}
				}
				2{
					direction	= 0
					cible	= Vector{0, 1, 0}
				}
				else{}
			}
			radius := 40

			for num in 0..nb{
				pos		:= Vector{x*(num+1), y*direction, 0}
				norm := mult(100, cible.normalize())

				//name	norm	radius	pos	cooldown	time
				app.attaques  << Meteor{Attaques_name.meteor, norm, radius, pos,  200, 500}
			}
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
			if count < 1 {
				mut max_score := app.score[0]
				for i in app.score {
					if i > max_score {
						max_score = i
					}
				}
				nb := int(max_score/10 +1)-app.attaques.len

				rota := rand.f64_in_range(0, 2*math.pi) or {0}

				mut sens := rand.int_in_range(0, 2) or {0}
				if sens == 0{
					sens = -1
				}

				temps_tour := 2*f64(sens)*math.pi*app.center_list[0].radius/rand.f64_in_range(200, 400) or {200}
				cooldown := rand.int_in_range(100, 200) or {100}
				time_laser := rand.int_in_range(300, 500) or {100}

				for laser_num in 0..nb{
					// name	rotation	temps_tour cooldown	time
					app.attaques  << Laser{Attaques_name.laser, rota+(math.pi/f64(nb))*laser_num*f64(nb), temps_tour, cooldown, time_laser}
				}
			}
		}
		4{
			mut max_score := app.score[0]
			for i in app.score {
				if i > max_score {
					max_score = i
				}
			}
			nb := int(max_score/10 +1)-app.attaques.len

			center := rand.int_in_range(0, app.center_list.len) or {0}

			cooldown := rand.int_in_range(100, 200)	or {100}
			time_missile := rand.int_in_range(100, 200) or {100}

			for _ in 0..nb{
				radius := rand.f64_in_range(10, 40)	or{0}

				mut cible :=(app.center_list[center].dist).turn(rand.f64_in_range(0, math.pi*2) or {0})

				direction := (cible).normalize()

				cible = cible + Vector{app.win_width/2, app.win_height/2, 0}

				// name	radius	pos	cible	direction cooldown	time
				app.attaques  << Missile{Attaques_name.missile, radius, Vector{app.win_width/2, app.win_height/2, 0}, cible, direction, cooldown, time_missile}
			}
		}
		else{}
	}
}
