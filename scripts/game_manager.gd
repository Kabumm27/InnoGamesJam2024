extends Node
class_name GameManager

@onready var ui: GameMenu = $%CanvasLayer

var players: Array[Player] = []
var team_yellow: Array[Player] = []
var team_blue: Array[Player] = []

var game_over = false

func _ready():
	for node in get_node("../Players").get_children():
		var player = node as Player
		players.push_back(player)
		if player.team == Enums.Team.Yellow:
			team_yellow.push_back(player)
		else:
			team_blue.push_back(player)


func _process(_delta):
	if !game_over:
		var team_yellow_dead = team_yellow.all(player_is_dead)
		var team_blue_dead = team_blue.all(player_is_dead)

		if team_yellow_dead:
			end_game(Enums.Team.Blue)
		elif team_blue_dead:
			end_game(Enums.Team.Yellow)


func player_is_dead(player):
	return !player.visible || player.health <= 0


func end_game(team: Enums.Team):
	await get_tree().create_timer(3.0).timeout
	ui.show_winning_screen(team)
	game_over = true
	pause_game()

func pause_game():
	get_tree().paused = true
