import rand

fn (mut app App) new_att(){
	app.attaques  << Orbs_annil{[rand.int_in_range(0, app.at_pt_list.len) or {0}], 500, 10}
}