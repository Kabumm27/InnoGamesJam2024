extends Node2D

@onready var fire: AnimatedSprite2D = $fire
@onready var fire_ending: AnimatedSprite2D = $fire_ending
@onready var burning_time: Timer = $burning_time

func _ready() -> void:
	fire.play()
	burning_time.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.has_method('reduce_health')):
		body.reduce_health(1)


func _on_burning_time_timeout() -> void:
	fire.stop()
	fire.hide()
	fire_ending.play()
	
func fire_out() -> void:
	await fire_ending.animation_finished