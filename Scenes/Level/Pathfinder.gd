extends Navigation2D
class_name Pathfinder

#### ACCESSORS ####

func is_class(value: String): return value == "Pathfinder" or .is_class(value)
func get_class() -> String: return "Pathfinder"


#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("query_path", self, "_on_query_path")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_query_path(who: Actor, from: Vector2, to: Vector2):
	var path = get_simple_path(from, to)
	Events.emit_signal("send_path", who, path)
