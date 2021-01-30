extends Actor
class_name Enemy

onready var statemachine = $StatesMachine
onready var chase_state = $StatesMachine/Chase
onready var seek_state = $StatesMachine/Seek
onready var detection_area = $DetectionArea

export var debug : bool = false

var move_path := PoolVector2Array()

signal path_finished()

#### ACCESSORS ####

func is_class(value: String): return value == "Enemy" or .is_class(value)
func get_class() -> String: return "Enemy"

func set_move_path(value: PoolVector2Array): move_path = value
func get_move_path() -> PoolVector2Array: return move_path

func set_state(value): statemachine.set_state(value)
func get_state() -> StateBase : return statemachine.get_state()
func get_state_name() -> String: return statemachine.get_state_name()

#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("send_path", $StatesMachine/Wander, "_on_path_received")
	__ = Events.connect("send_path", chase_state, "_on_path_received")
	__ = Events.connect("send_path", seek_state, "_on_path_received")
	__ = detection_area.connect("area_entered", self, "_on_area_entered_detection_area")
	__ = detection_area.connect("body_entered", self, "_on_body_entered_detection_area")
	__ = detection_area.connect("body_exited", self, "_on_body_exited_detection_area")
	
	if debug:
		__ = statemachine.connect("state_changed", $StateLabel, "_on_state_changed")

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


func seek(light_source: LightBase):
	seek_state.set_light_source(light_source)
	set_state(seek_state)


func chase(target: Actor):
	chase_state.set_target(target)
	set_state(chase_state)


#### INPUTS ####

 
#### SIGNAL RESPONSES ####

func _on_body_entered_detection_area(body: PhysicsBody2D):
	if body is Player:
		chase(body)


func _on_body_exited_detection_area(body: PhysicsBody2D):
	if body is Player:
		set_state("Wander")


func _on_area_entered_detection_area(area: Area2D):
	if !area is LightBase:
		return

	if get_state_name() == "Wander":
		seek(area)

