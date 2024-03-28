
import gx

fn (mut app App) game_start(){
	app.attaques = []

	app.at_pt_list =  [Center{Vector{app.win_width/2, app.win_height/2, 0}, Vector{0, 100, 0}}]
	app.at_pt_list << Center{Vector{app.win_width/2, app.win_height/2, 0}, Vector{0, 150, 0}}
	app.at_pt_list << Center{Vector{app.win_width/2, app.win_height/2, 0}, Vector{0, 200, 0}}

	app.players_list = [Player{Vector{0, 0, 0}, 1, 1, 0, gx.red}]

	app.game = true
	app.score = 0
}