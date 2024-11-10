extends CanvasLayer
class_name GameMenu


func show_winning_screen(team: Enums.Team):
	if team == Enums.Team.Yellow:
		$CenterContainer/YellowWins.visible = true
		$ButtonContainer.visible = true
	elif team == Enums.Team.Blue:
		$CenterContainer/BlueWins.visible = true
		$ButtonContainer.visible = true


func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
