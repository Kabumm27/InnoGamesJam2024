extends CharacterBody2D

@export var map: Map

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var molotow: Sprite2D = $molotow
@onready var molotow_activated: AnimatedSprite2D = $molotow_activated

func toggle_collision(state: bool):
	collision_shape.disabled = !state
	molotow.hide()
	molotow_activated.visible = true
	molotow_activated.play()
