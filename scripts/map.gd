extends Node2D
class_name Map

@onready var bg: TileMapLayer = get_node("BackgroundTileMapLayer")
@onready var fg: TileMapLayer = get_node("PlayAreaTileMapLayer")


func tilemap_to_global(tilemap_pos: Vector2i):
	var new_pos = fg.map_to_local(tilemap_pos)
	return fg.to_global(new_pos)


func global_to_tilemap(global_pos: Vector2):
	var pos_relative_to_tilemap = fg.to_local(global_pos)
	return fg.local_to_map(pos_relative_to_tilemap)

func get_cells(vector: Vector2i):
	return fg.get_surrounding_cells(vector)
