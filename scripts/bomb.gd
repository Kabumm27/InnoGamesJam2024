extends CharacterBody2D

@export var map: Map

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var timer: Timer = $Timer

# animations
@onready var bomb: Sprite2D = $animations/bomb
@onready var activated_animation: AnimatedSprite2D = $animations/activated_animation

const DAMAGE = 40
const EXPLOSION = preload("res://scenes/explosion.tscn")

func toggle_collision(state: bool):
	collision_shape.disabled = !state
	activated_animation.visible = true
	activated_animation.play() # start timer on first "collision" (pick up)
	timer.start()

func _on_timer_timeout():
	# var direction = Vector2i(Vector2.RIGHT.rotated(global_rotation).round())
	var tilemap_pos = map.global_to_tilemap(global_position)

	activated_animation.stop()
	activated_animation.hide()
	bomb.hide()
	var tiles = map.get_cells(tilemap_pos)
	tiles.append(tilemap_pos)
	var explosions = []
	for tile in tiles:
		var expl = EXPLOSION.instantiate()
		explosions.append(expl)
		self.add_child(expl)
		expl.global_position = map.tilemap_to_global(tile)
		print('tile explosion ', tile, tilemap_pos)
	
	await explosions[0].animation_finished()

	print('timeout')
	queue_free()
	
func get_shape(shape: String, tile_pos: Vector2i):
	match(shape):
		'circle':
			var circle = [tile_pos, tile_pos]
			return circle
