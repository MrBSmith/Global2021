extends Actor
class_name Enemy

var path := PoolVector2Array()

#### ACCESSORS ####

func is_class(value: String): return value == "Enemy" or .is_class(value)
func get_class() -> String: return "Enemy"


#### BUILT-IN ####

func _physics_process(delta: float) -> void:
	if !path.empty():
		move(delta)

#### VIRTUALS ####



#### LOGIC ####

func move(delta: float):
	var target = path[0]
	var dir = position.direction_to(target)
	var real_speed = speed * delta
	var dist_to_target = position.distance_to(target)
	
	if real_speed > dist_to_target:
		real_speed = dist_to_target
	
	var velocity = dir * real_speed
	position += velocity
	
	if position.distance_to(target) < 2.0:
		position = target
		path.remove(0)

#### INPUTS ####

#### MOVEMENT TEST ####
#func _input(_event: InputEvent) -> void:
#	if Input.is_action_just_pressed("click"):
#		var mouse_pos = get_global_mouse_position()
#		path = get_parent().get_simple_path(position, mouse_pos)
 
#### SIGNAL RESPONSES ####
