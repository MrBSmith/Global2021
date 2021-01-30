extends KinematicBody2D
class_name Actor

onready var level_node = get_parent()

export var speed : float = 200.0

#### ACCESSORS ####

func is_class(value: String): return value == "Actor" or .is_class(value)
func get_class() -> String: return "Actor"


#### BUILT-IN ####


#### VIRTUALS ####



#### LOGIC ####




#### INPUTS ####


#### SIGNAL RESPONSES ####
