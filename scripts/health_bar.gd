extends HBoxContainer
const PLAYER_HEART_FULL = preload("res://assets/ui/player_heart_full.png")
const PLAYER_HEART_EMPTY = preload("res://assets/ui/player_heart_empty.png")

func update_health(health: int):
	for i in get_child_count():
		if health >= i:
			get_child(i).texture = PLAYER_HEART_FULL
		else:
			get_child(i).texture = PLAYER_HEART_EMPTY
