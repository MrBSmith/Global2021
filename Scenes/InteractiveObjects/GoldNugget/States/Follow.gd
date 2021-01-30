extends Node
class_name GoldNuggetFollowState

const SPEED := 100.0
var target : Node2D = null setget set_target, get_target

#### ACCESSORS ####

func is_class(value: String): return value == "GoldNuggetFollowState" or .is_class(value)
func get_class() -> String: return "GoldNuggetFollowState"

func set_target(value: Node2D): target = value
func get_target() -> Node2D: return target


#### BUILT-IN ####



#### VIRTUALS ####

func update(delta: float):
	if target != null:
		var obj_pos = owner.get_position()
		var target_pos = target.get_position()
		var target_dir = obj_pos.direction_to(target_pos)
		var velocity = target_dir * SPEED * delta
		
		if obj_pos.distance_to(target_pos) < SPEED * delta:
			owner.set_position(target_pos)
		else:
			owner.set_position(obj_pos + velocity)

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
