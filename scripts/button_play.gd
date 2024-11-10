extends Button

const PLAY_BUTTON = preload("res://assets/sprites/play_button.png")
const PLAY_BUTTON_HOVER = preload("res://assets/sprites/play_button_hover.png")

var _active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = PLAY_BUTTON

func _on_button_mouse_entered() -> void:
	_active = true
	icon = PLAY_BUTTON_HOVER


func _on_button_mouse_exited() -> void:
	_active = false
	icon = PLAY_BUTTON


func _on_button_pressed() -> void:
	pass # Replace with function body.
