extends Area2D

@onready var map: Map = $%Map

@export var push = 1

var bomb_placed = false

func _on_body_entered(body: Node2D) -> void:
	
	if bomb_placed:
		var tilemap_pos = map.global_to_tilemap(global_position)
		
		var e = tilemap_pos
		e.x += push
		
		body.global_position = map.tilemap_to_global(e)
	else:
		bomb_placed = true
	
	if body.has_method('light_up'):
		body.light_up()


func _on_body_exited(body: Node2D) -> void:
	bomb_placed = false
	print('body left', body)
