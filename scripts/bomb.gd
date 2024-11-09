extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var timer: Timer = $Timer

# animations
@onready var activated_animation: AnimatedSprite2D = $animations/activated_animation
@onready var explosion: AnimatedSprite2D = $animations/explosion

func toggle_collision(state: bool):
	collision_shape.disabled = !state
	activated_animation.play() #start timer on first "collision" (pick up)
	timer.start()

func _on_timer_timeout():
	activated_animation.stop()
	explosion.play()
	print('timeout')
