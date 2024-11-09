extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func toggle_collision(state: bool):
  collision_shape.disabled = !state
