import math
import gx

const color_player = [gx.pink, gx.cyan, gx.yellow, gx.orange]

fn (mut app App) game_start() {
	app.attaques = []

	nb_center := 3

	app.center_list = [
		Center{Vector{app.win_width / 2, app.win_height / 2, 0}, Vector{0, 100, 0}, 100},
	]
	for nb in 1 .. nb_center {
		change := 100 + 50 * nb
		app.center_list << Center{Vector{app.win_width / 2, app.win_height / 2, 0}, Vector{0, change, 0}, change}
	}

	app.players_list = [Player{Vector{0, 0, 0}, 0, 1, 0, true, color_player[0]}]
	rota := 2 * math.pi / f64(app.player_nb)
	mut nb := 1
	for app.players_list.len < app.player_nb {
		app.players_list << Player{Vector{0, 0, 0}, rota * nb, 1, 0, true, color_player[nb]}
		nb += 1
	}

	for mut p in app.players_list {
		p.center_changer(0, app)
	}

	app.death_screen_time = 35
	app.game = true
	for i in 0 .. app.score.len {
		app.score[i] = 0
	}
}
