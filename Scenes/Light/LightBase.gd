extends Area2D
class_name LightBase

var active : bool = false setget set_active, is_active

#### ACCESSORS ####

func is_class(value: String): return value == "LightBase" or .is_class(value)
func get_class() -> String: return "LightBase"

func set_active(value: bool):
	if value == active:
		return
	
	active = value
	set_visible(value)
	Events.emit_signal("light_activated", self, active)

func is_active() -> bool : return active

#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
