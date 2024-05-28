
fn (mut app App) delt_att(){ 
	mut to_supr := []int{}
	for ind, att in app.attaques{
		if att.time == 0{
			to_supr << ind
		}
	}

	mut i := 0
	for ind in to_supr{
		app.attaques.delete(ind - i)
		i += 1
	}
	
	for y in 0 .. app.score.len {
		if app.players_list[y].is_alive{
			app.score[y] += i
		}
	}
}