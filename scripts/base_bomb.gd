extends CharacterBody2D
class_name BaseBomb

var damage = 1
var fuse_time = 5.0
var explosion_size = 3

var spawn_side: Enums.Team = Enums.Team.None
var last_touched_by: Enums.Team = Enums.Team.None


func toggle_collision(state: bool):
	call_deferred("toggle_collision_deferred", state)
