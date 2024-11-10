extends Button

const BACK_BUTTON = preload("res://assets/sprites/back_button.png")
const BACK_BUTTON_HOVER = preload("res://assets/sprites/back_button_hover.png")

var _active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = BACK_BUTTON

func _on_button_mouse_entered() -> void:
	_active = true
	icon = BACK_BUTTON_HOVER

func _on_button_mouse_exited() -> void:
	_active = false
	icon = BACK_BUTTON
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
