
fn (mut app App) check_death(){
	mut alive := false
	for mut p in app.players_list{
		for att in app.attaques{
			if att.check(p){
				p.is_alive = false
			}
		}
		if p.is_alive == true{
			alive = true
		}
	}
	if !alive{
		app.game = false
	}
}