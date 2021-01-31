extends Control
class_name GameOver

var level_scene = load("res://Scenes/Level/Level.tscn")
var input_ready : bool = false

#### ACCESSORS ####

func is_class(value: String): return value == "GameOver" or .is_class(value)
func get_class() -> String: return "GameOver"


#### BUILT-IN ####

func _ready() -> void:
	var __ = $Timer.connect("timeout", self, "_on_timer_timeout")
	$Timer.start()

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####


func _input(event: InputEvent) -> void:
	if event is InputEventKey && input_ready:
		var __ = get_tree().change_scene_to(level_scene)


#### SIGNAL RESPONSES ####

func _on_timer_timeout():
	input_ready = true
