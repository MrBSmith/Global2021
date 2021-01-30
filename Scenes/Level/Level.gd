extends Node2D
class_name Level

const gold_nugget_scene = preload("res://Scenes/InteractiveObjects/GoldNugget/GoldNugget.tscn")

onready var walls_node = $Navigation2D/Walls
onready var floor_node = $Navigation2D/Floor
onready var fog_node = $Navigation2D/FogOfWar

onready var tile_size = floor_node.get_cell_size()

export var gold_objective : int = 5

#### ACCESSORS ####

func is_class(value: String): return value == "Level" or .is_class(value)
func get_class() -> String: return "Level"


#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("damage_tile", self, "_on_tile_damaged")
	
	randomize()
	init_fog_of_war()
	init_floor_tiles()


#### VIRTUALS ####



#### LOGIC ####

func init_floor_tiles():
	for cell in walls_node.get_used_cells():
		floor_node.set_cellv(cell, -1)


func init_fog_of_war():
	var map_cells = floor_node.get_used_cells()
	var fog_tile_size = Vector2(8, 8)
	
	for cell in map_cells:
		for i in range(tile_size.y / fog_tile_size.y):
			for j in range(tile_size.x / fog_tile_size.x):
				fog_node.add_fog_tile(cell * tile_size + Vector2(j, i) * fog_tile_size + (fog_tile_size / 2))


func is_position_walkable(pos: Vector2) -> bool:
	var wall_tiles = walls_node.get_used_cells()
	var floor_tiles = floor_node.get_used_cells()
	
	var cell = floor_node.world_to_map(pos)
	
	return cell in floor_tiles && !cell in wall_tiles


func damage_tile(cell: Vector2):
	if !cell in walls_node.get_used_cells():
		return
	
	var cell_id = walls_node.get_cellv(cell)
	var tileset = walls_node.get_tileset()
	var cell_name = tileset.tile_get_name(cell_id)
	
	var floor_tile_id = tileset.find_tile_by_name("Floor")
	
	if cell_name == "Soil" or cell_name == "Gold":
		walls_node.set_cellv(cell, -1)
		floor_node.set_cellv(cell, floor_tile_id)
		if cell_name == "Gold":
			var gold_nugget = gold_nugget_scene.instance()
			gold_nugget.set_position(cell * tile_size + tile_size / 2)
			add_child(gold_nugget)


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_tile_damaged(cell: Vector2):
	damage_tile(cell)
