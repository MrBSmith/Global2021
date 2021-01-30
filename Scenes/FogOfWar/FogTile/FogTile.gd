extends Area2D
class_name FogTile

var state_map : Dictionary = {
	"hidden": Color.black,
	"visible": Color.transparent,
	"not_visible": Color(0, 0, 0, 0.4)
}

var state : String = state_map.keys()[0] setget set_state, get_state

#### ACCESSORS ####

func is_class(value: String): return value == "FogTile" or .is_class(value)
func get_class() -> String: return "FogTile"

func set_state(value: String):
	if state == value:
		return
	
	if !value in state_map.keys():
		print_debug("The given value isn't a key in the state_map dictonary")
	
	if value == "not_visible":
		if is_enlightened():
			return
	
	state = value
	$ColorRect.set_frame_color(state_map[state])

func get_state() -> String: return state


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func is_enlightened() -> bool:
	for area in get_overlapping_areas():
		if area.is_class("LightBase") && area.is_active():
			return true
	return false

#### INPUTS ####



#### SIGNAL RESPONSES ####
