extends PathFollow2D

@onready var belt_path_follow: PathFollow2D = $"."

@export var duration :float = 10.0
@export var speed :float = 400.0

var hasSend = false

signal _end_reached

func _ready():
	pass
	#var parentNode := belt_path_follow.get_parent().get_parent() as Node2D
	#belt_path_follow.progress_ratio = 0
#
	#var tween :Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(belt_path_follow, 'progress_ratio', 1, duration)
	


func _physics_process(delta):
	belt_path_follow.set_progress(belt_path_follow.get_progress() + speed * delta)
	if belt_path_follow.progress_ratio == 1 && !hasSend:
		_end_reached.emit()
		hasSend = true
		
