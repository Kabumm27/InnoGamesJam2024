extends CharacterBody2D
class_name BaseBomb

var damage = 1
var fuse_time = 5.0
var explosion_size = 3


func toggle_collision(state: bool):
	call_deferred("toggle_collision_deffered", state)
