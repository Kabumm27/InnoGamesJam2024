extends Node2D

@export var min_spawn_time = 10
@export var max_spawn_time = 20

@export var bombs: Array[PackedScene] = []

@onready var spawn_timer: Timer = $SpawnTimer
@onready var map: Map = $%Map


func spawn_bomb():
	if bombs.size() > 0:
		var bomb = bombs.pick_random().instantiate()
		bomb.map = map
		# bomb.global_position = global_position
		add_child(bomb)


func _ready():
	spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)


func _on_spawn_timer_timeout():
	spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	spawn_bomb()
