extends Node2D
class_name InteractiveObject

onready var interact_area = $Area2D

#### ACCESSORS ####

func is_class(value: String): return value == "InteractiveObject" or .is_class(value)
func get_class() -> String: return "InteractiveObject"


#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("interact", self, "_on_interact")

#### VIRTUALS ####

func interact():
	pass

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_interact():
	var bodies_array = $Area2D.get_overlapping_bodies()
	for body in bodies_array:
		if body is Player:
			interact()
