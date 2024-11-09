extends CharacterBody2D
class_name Player

# @export 
var speed = 400

@onready var map: Map = get_node("%Map")
@onready var indicator: ColorRect = get_node("Indicator")
@onready var carry_location: Node2D = get_node("CarryLocation")

var handle_object: Node2D = null
var carry_object: Node2D = null


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func pick_up(object: Node2D):
	if object.has_method("toggle_collision"):
		object.toggle_collision(false)
	object.get_parent().remove_child(object)
	object.global_position = Vector2.ZERO
	carry_location.add_child(object)
	carry_object = handle_object


func drop(object: Node2D):
	carry_object = null
	object.get_parent().remove_child(object)
	get_tree().get_root().add_child(object)

	var direction = Vector2i(Vector2.RIGHT.rotated(global_rotation))
	var tilemap_pos = map.global_to_tilemap(global_position)
	object.global_position = map.tilemap_to_global(tilemap_pos + direction)

	await get_tree().create_timer(0.03).timeout

	if object.has_method("toggle_collision"):
		object.toggle_collision(true)


func _process(_delta):
	if Input.is_action_just_pressed('use'):
		if !carry_object and handle_object:
			pick_up(handle_object)
		elif carry_object:
			drop(carry_object)


func _physics_process(_delta):
	get_input()
	look_at(global_transform.origin + velocity)
	move_and_slide()


func _on_handle_area_body_entered(body: Node2D):
	handle_object = body
	indicator.visible = true


func _on_handle_area_body_exited(_body: Node2D):
	handle_object = null
	indicator.visible = false
