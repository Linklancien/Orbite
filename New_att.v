import rand

fn (mut app App) new_att(){
	match rand.int_in_range(0, 50) or{0}{
		1{
			if app.attaques.len + 1 < app.at_pt_list.len {
				app.attaques  << Orbs_annil{[rand.int_in_range(0, app.at_pt_list.len) or {0}], 200, 50}
			}
		}
		2{
			mut x := rand.f64_in_range(0, app.win_width)	or{0}
			mut y := rand.f64_in_range(0, app.win_height)	or{0}
			if x > app.win_width/4	{x = app.win_width/4}
			if y > app.win_height/4	{y = app.win_height/4}
			if app.win_width*3/4 > x	{x = app.win_width*3/4}
			if app.win_height*3/4 > y	{y = app.win_height*3/4}
			pos := Vector{x, y, 0}
			radius := rand.f64_in_range(10, 50)	or{0}
			norm := mult(radius, (app.players_list[0].pos - pos).normalize())
			app.attaques  << Meteor{norm, radius, pos,  50, 500}
		}
		else{}
	}
}