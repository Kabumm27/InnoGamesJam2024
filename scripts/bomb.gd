extends BaseBomb

@export var map: Map

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var timer: Timer = $Timer

# animations
@onready var bomb: Sprite2D = $animations/bomb
@onready var bomb_electrical: Sprite2D = $animations/bomb_electrical
@onready var bomb_bubble: Sprite2D = $animations/bomb_bubble

@onready var sound_normal: AudioStreamPlayer2D = $sounds/normal
@onready var sound_bubble: AudioStreamPlayer2D = $sounds/bubble
@onready var sound_electric: AudioStreamPlayer2D = $sounds/electric

@onready var pattern: Sprite2D = $pattern_sprites/pattern

@onready var activated_animation: AnimatedSprite2D = $animations/activated_animation

"res://assets/sounds/electric-sparking.mp3"
@export var explosion_type: PATTERNS

const EXPLOSION = preload("res://scenes/explosion.tscn")
enum PATTERNS {CIRCLE = 0, CROSS = 1, PLUS = 2, VERTICAL = 3}
enum TYPE {NORMAL = 0, ELECTRICAL = 1, BUBBLE = 2}
var type: Sprite2D = null
var animation_name = 'normal'
var selected_type: int
var activated_sound: AudioStreamPlayer2D = null

func _ready():
	z_index = 25

	timer.wait_time = fuse_time
		
	selected_type = TYPE.values()[range(3).pick_random()]
	if selected_type == TYPE.NORMAL:
		type = bomb
		animation_name = 'normal'
		activated_sound = sound_normal
	elif selected_type == TYPE.ELECTRICAL:
		type = bomb_electrical
		animation_name = 'electric'
		activated_sound = sound_electric
	elif selected_type == TYPE.BUBBLE:
		type = bomb_bubble
		animation_name = 'bubble'
		activated_sound = sound_bubble
		
	type.visible = true
func _process(_delta):
	if activated_animation.visible && activated_animation.material:
		activated_animation.material.set_shader_parameter("time", timer.time_left)


func toggle_collision_deferred(state: bool):
	collision_shape.disabled = !state
	type.hide()
	activated_animation.visible = true
	activated_animation.play(animation_name) # start timer on first "collision" (pick up)
	activated_sound.play()
	
	if timer.is_stopped():
		timer.start()


func pause_timer(pause: bool):
	timer.paused = pause
	if activated_animation.visible && activated_animation.material:
		activated_animation.material.set_shader_parameter("time", 0)


func _on_timer_timeout():
	var tilemap_pos = map.global_to_tilemap(global_position)

	activated_animation.stop()
	activated_animation.hide()
	pattern.hide()
	var tiles = get_shape(explosion_type, tilemap_pos) # map.get_cells(tilemap_pos)
	# tiles.append(tilemap_pos)
	var explosions = []
	for tile in tiles:
		var expl = EXPLOSION.instantiate()
		expl.type = selected_type
		explosions.append(expl)
		self.add_child(expl)
		expl.global_position = map.tilemap_to_global(tile)
	await explosions[0].animation_finished()

	call_deferred("free")


func get_shape(pattern: PATTERNS, tile_pos: Vector2i):
	match (pattern):
		PATTERNS.CROSS:
			var cross = [tile_pos]
			for i in [[-1, -1], [-1, 1], [1, -1], [1, 1]]:
				for j in range(1, explosion_size):
					var e = tile_pos
					e.x += i[0] * j
					e.y += i[1] * j
					cross.append(e)
			return cross
		PATTERNS.CIRCLE:
			var circle = []
			var explosion_size_squared = explosion_size * explosion_size
			for y in range(1 - explosion_size, explosion_size):
				for x in range(1 - explosion_size, explosion_size):
					var vec = Vector2i(tile_pos.x + x, tile_pos.y + y)
					if vec.distance_squared_to(tile_pos) < explosion_size_squared:
						circle.append(vec)
			return circle
		PATTERNS.PLUS:
			var plus = []
			for i in range(1 - explosion_size, explosion_size):
				var e = tile_pos
				e.x += i
				plus.append(e)
				var f = tile_pos
				f.y += i
				plus.append(f)
			return plus
		PATTERNS.VERTICAL:
			var vertical = []
			for i in range(1 - explosion_size, explosion_size):
				var e = tile_pos
				e.y += i
				vertical.append(e)
			return vertical
