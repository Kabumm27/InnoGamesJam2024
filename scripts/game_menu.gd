extends Node2D
class_name GameMenu


func show_winning_screen(team: Enums.Team):
	if team == Enums.Team.Yellow:
		$EndbildYellowWins.visible = true
	elif team == Enums.Team.Blue:
		$EndbildBlueWins.visibible = true
