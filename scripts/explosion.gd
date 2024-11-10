extends Node2D

@onready var explosion: AnimatedSprite2D = $explosion
@onready var explosion_bubble: AudioStreamPlayer2D = $sounds/explosion_bubble
@onready var explosion_normal: AudioStreamPlayer2D = $sounds/explosion_normal

enum TYPE {NORMAL = 0, ELECTRICAL = 1}

@export var type: TYPE

func _ready() -> void:
	explosion.play()
	
	if type == TYPE.NORMAL:
		explosion.play('normal')
		explosion_normal.play()
	elif type == TYPE.ELECTRICAL:
		explosion.play('bubble')
		explosion_bubble.play()

func animation_finished() -> void:
	await explosion.animation_finished

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.has_method('reduce_health')):
		body.reduce_health(1)
