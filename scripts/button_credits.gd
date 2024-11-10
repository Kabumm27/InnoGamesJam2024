extends Button

const CREDITS_BUTTON = preload("res://assets/sprites/credits_button.png")
const CREDITS_BUTTON_HOVER = preload("res://assets/sprites/credits_button_hover.png")

var _active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = CREDITS_BUTTON

func _on_button_mouse_entered() -> void:
	_active = true
	icon = CREDITS_BUTTON_HOVER


func _on_button_mouse_exited() -> void:
	_active = false
	icon = CREDITS_BUTTON
	
func _on_button_pressed() -> void:
	pass # Replace with function body.
