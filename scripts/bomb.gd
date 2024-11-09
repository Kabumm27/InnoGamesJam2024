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
	var tiles = get_shape('vertical', tilemap_pos) #map.get_cells(tilemap_pos)
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
		'x':
			var cross = [tile_pos]
			for i in [[-1,-1], [-1,1], [1, -1], [1, 1]]:
				var e = tile_pos
				e.x += i[0]
				e.y += i[1]
				cross.append(e)
			return cross
		'circle':
			var circle = [tile_pos]
			for i in [[-1,0], [0,-1], [0, 1], [1,0]]:
				var e = tile_pos
				e.x += i[0]
				e.y += i[1]
				circle.append(e)
			return circle
		'+':
			var plus = []
			for i in range(-2, 2):
				var e = tile_pos
				e.x += i
				plus.append(e)
				var f = tile_pos
				f.y += i
				plus.append(f)
			return plus
		'vertical':
			var vertical = []
			for i in range(-5, 5):
				var e = tile_pos
				e.y += i
				vertical.append(e)
			return vertical
