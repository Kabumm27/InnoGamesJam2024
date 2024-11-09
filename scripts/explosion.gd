extends Node2D

@onready var explosion: AnimatedSprite2D = $explosion

func _ready() -> void:
	explosion.play()

func animation_finished() -> void:
	await explosion.animation_finished

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.has_method('reduce_health')):
		body.reduce_health(1)
