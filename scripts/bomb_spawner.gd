extends Node2D
class_name BombSpawner

var min_spawn_time = 10
var max_spawn_time = 20

var bombs: Array[PackedScene] = []

@onready var spawn_timer: Timer = $SpawnTimer
@onready var map: Map = $%Map


func spawn_bomb():
	if bombs.size() > 0:
		var bomb = bombs.pick_random().instantiate() as BaseBomb
		bomb.map = map
		# bomb.global_position = global_position
		add_child(bomb)


func initalize():
	spawn_timer.wait_time = randf_range(1, 3)
	spawn_timer.start()


func _on_spawn_timer_timeout():
	spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	spawn_bomb()


func _on_detector_body_entered(_body: Node2D):
	spawn_timer.paused = true


func _on_detector_body_exited(_body: Node2D):
	spawn_timer.paused = false
