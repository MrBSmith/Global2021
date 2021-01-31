extends Control
class_name GameOver

var level_scene = load("res://Scenes/Level/Level.tscn")

#### ACCESSORS ####

func is_class(value: String): return value == "GameOver" or .is_class(value)
func get_class() -> String: return "GameOver"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var __ = get_tree().change_scene_to(level_scene)


#### SIGNAL RESPONSES ####
