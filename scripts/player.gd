extends CharacterBody2D
class_name Player

# @export 
var speed = 400
var health = 100

@export var gamepad_id = 0

@onready var map: Map = $%Map
@onready var indicator: ColorRect = $Indicator
@onready var carry_location: Node2D = $CarryLocation
@onready var rotation_node: Node2D = $RotationNode

@onready var sprite_default: Sprite2D = $CharacterDefault
@onready var sprite_carry: Sprite2D = $CharacterCarry

var handle_object: Node2D = null
var carry_object: Node2D = null


func pick_up(object: Node2D):
	if object.has_method("toggle_collision"):
		object.toggle_collision(false)
	object.get_parent().remove_child(object)
	object.global_position = Vector2.ZERO
	carry_location.add_child(object)
	carry_object = handle_object

func reduce_health(damage: int):
	health -= damage

func drop(object: Node2D):
	carry_object = null
	object.get_parent().remove_child(object)
	get_tree().get_root().add_child(object)

	var direction = Vector2i(Vector2.RIGHT.rotated(rotation_node.global_rotation).round())
	var tilemap_pos = map.global_to_tilemap(global_position)
	object.global_position = map.tilemap_to_global(tilemap_pos + direction)

	await get_tree().create_timer(0.03).timeout

	if object.has_method("toggle_collision"):
		object.toggle_collision(true)


func set_sprite_state():
	sprite_carry.visible = !!carry_object
	sprite_default.visible = !carry_object

	var rot = roundi(rotation_node.rotation_degrees + 90) % 360
	if rot % 180 != 0:
		sprite_carry.flip_h = rot < 180
		sprite_default.flip_h = rot < 180


func _input(event):
	if event.device == gamepad_id:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * speed

		if event.is_action_pressed('use'):
			if !carry_object and handle_object:
				pick_up(handle_object)
			elif carry_object:
				drop(carry_object)


func _process(_delta):
	if (health <= 0):
		print('player died')
	
	if (!is_instance_valid(carry_object)):
		carry_object = null

	set_sprite_state()


func _physics_process(_delta):
	rotation_node.look_at(global_transform.origin + velocity)
	move_and_slide()


func _on_handle_area_body_entered(body: Node2D):
	handle_object = body
	indicator.visible = true


func _on_handle_area_body_exited(_body: Node2D):
	handle_object = null
	indicator.visible = false
