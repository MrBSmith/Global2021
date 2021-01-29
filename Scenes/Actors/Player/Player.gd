extends Actor
class_name Player

var v_movement : float = 0.0
var h_movement : float = 0.0

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"


#### BUILT-IN ####

func _physics_process(_delta: float) -> void:
	var dir = Vector2(v_movement, h_movement).normalized()
	var velocity = dir * speed
	
	var __ = move_and_slide(velocity)
 

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####

func _input(_event: InputEvent) -> void:
	v_movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	h_movement = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")


#### SIGNAL RESPONSES ####
