extends Node2D
class_name Level

onready var walls_node = $Navigation2D/Walls
onready var fog_node = $Navigation2D/FogOfWar

#### ACCESSORS ####

func is_class(value: String): return value == "Level" or .is_class(value)
func get_class() -> String: return "Level"


#### BUILT-IN ####

func _ready() -> void:
	randomize()
	init_fog_of_war()


#### VIRTUALS ####



#### LOGIC ####

func init_fog_of_war():
	var map_cells = walls_node.get_used_cells()
	var tile_size = walls_node.get_cell_size()
	var fog_tile_size = Vector2(8, 8)
	
	for cell in map_cells:
		for i in range(tile_size.y / fog_tile_size.y):
			for j in range(tile_size.x / fog_tile_size.x):
				fog_node.add_fog_tile(cell * tile_size + Vector2(j, i) * fog_tile_size + (fog_tile_size / 2))



func is_position_walkable(pos: Vector2) -> bool:
	var cell = walls_node.world_to_map(pos)
	
	var tileset = walls_node.get_tileset()
	var cell_id = walls_node.get_cellv(cell)
	
	if cell_id == TileMap.INVALID_CELL:
		return false
	
	var tile_name = tileset.tile_get_name(cell_id)
	
	return tile_name.is_subsequence_ofi("floor")



#### INPUTS ####



#### SIGNAL RESPONSES ####
