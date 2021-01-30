extends Actor
class_name Enemy

onready var statemachine = $StatesMachine

var move_path := PoolVector2Array()

signal path_finished()

#### ACCESSORS ####

func is_class(value: String): return value == "Enemy" or .is_class(value)
func get_class() -> String: return "Enemy"

func set_move_path(value: PoolVector2Array): move_path = value
func get_move_path() -> PoolVector2Array: return move_path

func set_state(value: StateBase): statemachine.set_state(value)
func get_state() -> StateBase : return statemachine.get_state()
func get_state_name() -> String: return statemachine.get_state_name()

#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("send_path", $StatesMachine/Wander, "_on_path_received")

#### VIRTUALS ####



#### LOGIC ####

func move(delta: float):
	var target = move_path[0]
	var dir = position.direction_to(target)
	var real_speed = speed * delta
	var dist_to_target = position.distance_to(target)
	
	if real_speed > dist_to_target:
		real_speed = dist_to_target
	
	var velocity = dir * real_speed
	position += velocity
	
	if position.distance_to(target) < 2.0:
		position = target
		move_path.remove(0)
		if move_path.empty():
			emit_signal("path_finished")


#### INPUTS ####

##### MOVEMENT TEST ####
#func _input(_event: InputEvent) -> void:
#	if Input.is_action_just_pressed("click"):
#		var mouse_pos = get_global_mouse_position()
#		Events.emit_signal("query_path", self, position, mouse_pos)

 
#### SIGNAL RESPONSES ####


