extends Node2D

@onready var explosion: AnimatedSprite2D = $explosion

func _ready() -> void:
	explosion.play();

func animation_finished() -> void:
	await explosion.animation_finished;
