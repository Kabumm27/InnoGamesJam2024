extends Node2D

@onready var gravestone: Sprite2D = $gravestone
@onready var gravestone_p_1: Sprite2D = $gravestone_p1
@onready var gravestone_p_2: Sprite2D = $gravestone_p2
@onready var gravestone_p_3: Sprite2D = $gravestone_p3
@onready var gravestone_p_4: Sprite2D = $gravestone_p4

@export var player = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player == 0:
		gravestone_p_1.visible = true
	if player == 1:
		gravestone_p_2.visible = true
	if player == 2:
		gravestone_p_3.visible = true
	if player == 3:
		gravestone_p_4.visible = true
	else:
		gravestone.visible = true
