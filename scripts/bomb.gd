extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var timer: Timer = $Timer

# animations
@onready var bomb: Sprite2D = $animations/bomb
@onready var activated_animation: AnimatedSprite2D = $animations/activated_animation
@onready var explosion: AnimatedSprite2D = $animations/explosion

var DAMAGE = 40
var player: Player = null

func toggle_collision(state: bool, local_player: Player):
	collision_shape.disabled = !state
	activated_animation.visible = true
	activated_animation.play() #start timer on first "collision" (pick up)
	timer.start()
	player = local_player

func _on_timer_timeout():
	activated_animation.stop()
	activated_animation.hide()
	bomb.hide()
	explosion.visible = true
	explosion.play()
	player.reduce_health(DAMAGE)
	print('timeout')

func _on_explosion_animation_finished() -> void:
	queue_free()
