extends Node2D
class_name Level

onready var walls_node = $Navigation2D/Walls

#### ACCESSORS ####

func is_class(value: String): return value == "Level" or .is_class(value)
func get_class() -> String: return "Level"


#### BUILT-IN ####

func _ready() -> void:
	randomize()

#### VIRTUALS ####



#### LOGIC ####

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
