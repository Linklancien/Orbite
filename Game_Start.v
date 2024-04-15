
import math
import gx

fn (mut app App) game_start(){
	app.attaques = []

	app.center_list =  [Center{Vector{app.win_width/2, app.win_height/2, 0}, Vector{0, 100, 0}, 100}]
	app.center_list << Center{Vector{app.win_width/2, app.win_height/2, 0}, Vector{0, 150, 0}, 150}
	app.center_list << Center{Vector{app.win_width/2, app.win_height/2, 0}, Vector{0, 200, 0}, 200}

	app.players_list = [Player{Vector{0, 0, 0}, 0, 1, 0, true, gx.red}]
	rota := 2*math.pi/f64(app.player_nb)
	mut nb := 1
	for app.players_list.len < app.player_nb{
		app.players_list << Player{Vector{0, 0, 0}, rota*nb, 1, 0, true, gx.blue}
		nb += 1
	}
	
	for mut p in app.players_list{
		p.center_changer(0, app)
	}

	app.death_screen_time = 35
	app.game = true
	app.score[0] = 0
}