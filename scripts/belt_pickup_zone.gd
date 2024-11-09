extends Area2D

@onready var belt_path: Path2D = $"../BeltPath"

const BELT_PATH_FOLLOW = preload("res://scenes/BeltPathFollow.tscn")

func _on_body_entered(body: Node2D):
		print("Entered")
		var item := body as CharacterBody2D
		if item:
			#if item.name == "item":
			if item.has_method("toggle_collision"):
				item.toggle_collision(false)
				
			if item.has_method("pause_timer"):
				item.pause_timer(true)
				
			var beltPathFollowInstance = BELT_PATH_FOLLOW.instantiate()
			
			beltPathFollowInstance._end_reached.connect(enable_collision.bind(item))
			
			item.position = Vector2.ZERO
			belt_path.add_child(beltPathFollowInstance)
			
			item.get_parent().remove_child.call_deferred(item)
			await get_tree().create_timer(0.05).timeout
			beltPathFollowInstance.add_child(item)

			#beltPathFollowInstance.global_position = Vector2.ZERO
			
			print("item")
			#print(belt_path)
		else:
			print("No item")

func enable_collision(body: Node2D):
	if body.has_method("toggle_collision"):
		body.toggle_collision(true)
	if body.has_method("pause_timer"):
		body.pause_timer(false)
