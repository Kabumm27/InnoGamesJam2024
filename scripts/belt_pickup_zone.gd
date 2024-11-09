extends Area2D

@onready var belt_path: Path2D = $"../BeltPath"

const BELT_PATH_FOLLOW = preload("res://scenes/BeltPathFollow.tscn")

func _on_body_entered(body: Node2D):
		print("Entered")
		var bomb := body as CharacterBody2D
		if bomb:
			if bomb.name == "Bomb":
				if bomb.has_method("toggle_collision"):
					bomb.toggle_collision(false)
					
				var beltPathFollowInstance = BELT_PATH_FOLLOW.instantiate()
				
				bomb.position = Vector2.ZERO
				belt_path.add_child(beltPathFollowInstance)
				
				bomb.get_parent().remove_child.call_deferred(bomb)
				await get_tree().create_timer(0.05).timeout
				beltPathFollowInstance.add_child(bomb)

				#beltPathFollowInstance.global_position = Vector2.ZERO
				
				print("Bomb")
				#print(belt_path)
			else:
				print("No Bomb")
