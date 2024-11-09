extends Area2D

@onready var belt_path: Path2D = $"../BeltPath"

const BELT_PATH_FOLLOW = preload("res://scenes/BeltPathFollow.tscn")

func _on_body_entered(body: Node2D):
		print("Entered")
		var bomb := body as CharacterBody2D
		if bomb:
			if bomb.name == "Bomb":
				var beltPathFollowInstance = BELT_PATH_FOLLOW.instantiate()
				
				bomb.get_parent().remove_child(bomb)
				bomb.global_position = Vector2.ZERO
				
				beltPathFollowInstance.add_child(bomb)
				#beltPathFollowInstance.global_position = Vector2.ZERO
				belt_path.add_child(beltPathFollowInstance)
				print("Bomb")
				#print(belt_path)
			else:
				print("No Bomb")
