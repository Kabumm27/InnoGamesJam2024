extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var timer: Timer = $Timer
@onready var map: Map = get_node("%Map")

# animations
@onready var bomb: Sprite2D = $animations/bomb
@onready var activated_animation: AnimatedSprite2D = $animations/activated_animation
@onready var explosion: AnimatedSprite2D = $animations/explosion

const DAMAGE = 40
const EXPLOSION = preload("res://scenes/explosion.tscn")

func toggle_collision(state: bool):
	collision_shape.disabled = !state
	activated_animation.visible = true
	activated_animation.play() #start timer on first "collision" (pick up)
	timer.start()

func _on_timer_timeout():
	var direction = Vector2i(Vector2.RIGHT.rotated(global_rotation).round())
	var tilemap_pos = map.global_to_tilemap(global_position)

	activated_animation.stop()
	activated_animation.hide()
	bomb.hide()
	var expl = EXPLOSION.instantiate()
	self.add_child(expl)
	expl.global_position = map.tilemap_to_global(tilemap_pos + direction)
	
	await expl.animation_finished()

	print('timeout')
	queue_free()
	
