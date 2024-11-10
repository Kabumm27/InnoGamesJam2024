extends Node
class_name GameManager

var players: Array[Player] = []
var team_yellow: Array[Player] = []
var team_blue: Array[Player] = []

func _ready():
	for node in get_node("../Players").get_children():
		var player = node as Player
		players.push_back(player)
		if player.team == Enums.Team.Yellow:
			team_yellow.push_back(player)
		else:
			team_blue.push_back(player)


func _process(_delta):
	var team_yellow_dead = team_yellow.all(player_is_dead)
	var team_blue_dead = team_blue.all(player_is_dead)

	if team_yellow_dead:
		print("Team Blue won!")
		pause_game()
	elif team_blue_dead:
		print("Team Yellow won!")
		pause_game()


func player_is_dead(player):
	return !player.visible || player.health <= 0


func pause_game():
	get_tree().paused = true
