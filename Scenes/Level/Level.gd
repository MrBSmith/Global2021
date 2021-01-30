extends Node2D
class_name Level

const gold_nugget_scene = preload("res://Scenes/InteractiveObjects/GoldNugget/GoldNugget.tscn")

var level_size = Vector2(41, 20)

onready var walls_node = $Navigation2D/Walls
onready var floor_node = $Navigation2D/Floor
onready var fog_node = $Navigation2D/FogOfWar

onready var tile_size = floor_node.get_cell_size()

export var gold_objective : int = 6
export var debug := false

#### ACCESSORS ####

func is_class(value: String): return value == "Level" or .is_class(value)
func get_class() -> String: return "Level"


#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("damage_tile", self, "_on_tile_damaged")
	
	randomize()
	
	generate_level()
	
	init_fog_of_war()
	init_floor_tiles()
	


#### VIRTUALS ####



#### LOGIC ####


func generate_level():
	var soil_tile_id = walls_node.get_tileset().find_tile_by_name("Soil")
	var wall_tile_id = walls_node.get_tileset().find_tile_by_name("Wall")
	var gold_tile_id = walls_node.get_tileset().find_tile_by_name("Gold")
	
	var soil_noise = get_rdm_noise()
	while(!is_noise_valid(soil_noise)):
		soil_noise = get_rdm_noise()
	
	var wall_noise = get_rdm_noise()
	
	# Place soil and walls tiles
	for i in range(level_size.y):
		for j in range(level_size.x):
			var soil_value = soil_noise.get_noise_2d(j, i)
			
			if is_cell_map_boundary(Vector2(j, i)):
				walls_node.set_cell(j, i, wall_tile_id)
			elif soil_value > 0.2:
				if wall_noise.get_noise_2d(j, i) > 0.4:
					walls_node.set_cell(j, i, wall_tile_id)
				else:
					walls_node.set_cell(j, i, soil_tile_id)
	
	var wall_cells = walls_node.get_used_cells()
	wall_cells.shuffle()
	
	# Place gold
	for _i in range(gold_objective + float(gold_objective) / 2):
		var cell = wall_cells.pop_front()
		
		while(is_cell_map_boundary(cell) && walls_node.get_cellv(cell) == wall_tile_id):
			cell = wall_cells.pop_front()
		
		walls_node.set_cellv(cell, gold_tile_id)
	
	# Place level entrance
	var entry_cell = Vector2(level_size.x / 2, 0)
	
	for i in range(0, -3, -1):
		for j in range(-2, 3, 1):
			if j == -2 or j == 2 or i == -2:
				walls_node.set_cell(entry_cell.x + j, entry_cell.y + i, wall_tile_id)
			else:
				walls_node.set_cell(entry_cell.x + j, entry_cell.y + i, -1)
	
	# Place player
	$Player.set_position((entry_cell + Vector2.UP) * tile_size)
	


func is_noise_valid(noise: OpenSimplexNoise) -> bool:
	var entry_cell = Vector2(level_size.x / 2, 1)
	for i in range(-1, 2, 1):
		var value = noise.get_noise_2d(entry_cell.x + i, entry_cell.y)
		if value > 0.2:
			return false
	return true


func is_cell_map_boundary(cell: Vector2) -> bool:
	return cell.x == 0 or cell.y == 0 or \
		cell.x == level_size.x - 1 or cell.y == level_size.y - 1



func get_rdm_noise(period := 10.0, persistance:= 0.5):
	var noise = OpenSimplexNoise.new()
	
	# Configure
	noise.seed = randi()
	noise.octaves = 3
	noise.period = period
	noise.persistence = persistance
	
	return noise


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

func _input(_event: InputEvent) -> void:
	if debug && Input.is_action_just_pressed("debug_reinitilize_level"):
		walls_node.clear()
		generate_level()


#### SIGNAL RESPONSES ####

func _on_tile_damaged(cell: Vector2):
	damage_tile(cell)
