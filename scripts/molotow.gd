extends BaseBomb

@export var map: Map

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var molotow: Sprite2D = $molotow
@onready var molotow_activated: AnimatedSprite2D = $molotow_activated
@onready var glass_breaking: AudioStreamPlayer2D = $sounds/glass_breaking

const FIRE = preload("res://scenes/fire.tscn")

func _ready() -> void:
	z_index = 25

func toggle_collision_deferred(state: bool):
	collision_shape.disabled = !state
	molotow.hide()
	molotow_activated.visible = true
	molotow_activated.play()

func light_up():
	call_deferred("light_up_deferred")

func light_up_deferred():
	glass_breaking.play()
	var tilemap_pos = map.global_to_tilemap(global_position)
	molotow_activated.hide()
	var flames = []
	for i in range(-1, 2):
		print(i)
		var fire = FIRE.instantiate()
		flames.append(fire)
		self.add_child(fire)

		var tile = tilemap_pos
		tile.y += i
		fire.global_position = map.tilemap_to_global(tile)
	await flames[flames.size() - 1].fire_out();
	call_deferred("free")
