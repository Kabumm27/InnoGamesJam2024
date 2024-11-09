extends Node2D

@export var min_spawn_time = 10
@export var max_spawn_time = 20
@export var bombs: Array[PackedScene] = []

var left_spawners: Array[BombSpawner] = []
var right_spawners: Array[BombSpawner] = []

func _ready():
	for child in $Left.get_children():
		left_spawners.push_back(child as BombSpawner)
	for child in $Right.get_children():
		right_spawners.push_back(child as BombSpawner)

	for spawner in left_spawners + right_spawners:
		spawner.bombs = bombs
		spawner.min_spawn_time = min_spawn_time
		spawner.max_spawn_time = max_spawn_time
		spawner.initalize()
