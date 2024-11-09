extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method('light_up'):
		body.light_up()
