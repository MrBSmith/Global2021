extends KinematicBody2D
class_name Actor

onready var level_node = get_parent()

export var speed : float = 200.0

var direction := Vector2.UP setget set_direction, get_direction

#### ACCESSORS ####

func is_class(value: String): return value == "Actor" or .is_class(value)
func get_class() -> String: return "Actor"

func set_direction(value: Vector2): 
	direction = value.normalized()
	rotate_sprites()

func get_direction() -> Vector2: return direction


#### BUILT-IN ####



#### VIRTUALS ####

func rotate_sprites():
	pass

#### LOGIC ####



#### INPUTS ####


#### SIGNAL RESPONSES ####
