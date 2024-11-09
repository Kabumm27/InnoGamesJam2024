extends PathFollow2D

@onready var belt_path_follow: PathFollow2D = $"."

@export var duration :float = 10.0

func _ready():
	#print(belt_path_follow)
	belt_path_follow.progress_ratio = 0

	var tween :Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(belt_path_follow, 'progress_ratio', 1, duration)


#var _speed :float = 200.0
#
#func _physics_process(delta):
	#belt_path_2_follow.set_progress(belt_path_2_follow.get_progress() + _speed * delta)
