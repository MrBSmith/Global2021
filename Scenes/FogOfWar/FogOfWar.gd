extends Node2D
class_name FogOfWar

const fog_tile_scene = preload("res://Scenes/FogOfWar/FogTile/FogTile.tscn")

onready var fog_update_timer = $Timer

#### ACCESSORS ####

func is_class(value: String): return value == "FogOfWar" or .is_class(value)
func get_class() -> String: return "FogOfWar"


#### BUILT-IN ####

func _ready() -> void:
	var __ = fog_update_timer.connect("timeout", self, "_on_fog_update_timer_timeout")

#### VIRTUALS ####



#### LOGIC ####

func add_fog_tile(pos: Vector2):
	var fog_tile = fog_tile_scene.instance()
	fog_tile.set_position(pos)
	add_child(fog_tile)


func update_tile_visibility():
	for child in get_children():
		if !child is FogTile or child.get_state() != "visible":
			 continue
		
		if !child.is_enlightened():
			child.set_state("not_visible")

#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_fog_update_timer_timeout():
	update_tile_visibility()
