extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var timer: Timer = $Timer

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
	activated_animation.stop()
	activated_animation.hide()
	bomb.hide()
	var expl = EXPLOSION.instantiate()
	self.add_child(expl)
	
	await expl.animation_finished()

	#todo add explosion
	#explosion.visible = true
	#explosion.play()
	#await explosion.animation_finished
	print('timeout')
	queue_free()
	
