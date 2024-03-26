
fn (app App) check_death(){
	for p in app.players_list{
		for att in app.attaques{
			if att.check(p){
				println("DEAD")
			}
		}
	}
}