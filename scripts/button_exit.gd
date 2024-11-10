extends Button

const EXIT_BUTTON = preload("res://assets/sprites/exit_button.png")
const EXIT_BUTTON_HOVER = preload("res://assets/sprites/exit_button_hover.png")

var _active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = EXIT_BUTTON

func _on_button_mouse_entered() -> void:
	_active = true
	icon = EXIT_BUTTON_HOVER


func _on_button_mouse_exited() -> void:
	_active = false
	icon = EXIT_BUTTON
	
	
func _on_button_pressed() -> void:
	get_tree().quit() 
