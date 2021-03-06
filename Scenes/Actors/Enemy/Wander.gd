extends StateBase
class_name WanderState

onready var timer_node = $Timer

export var average_wait_time : float = 2.0
export(float, 0.0, 1.0) var wait_time_variance : float = 0.2

export var wander_radius : float = 50.0

#### ACCESSORS ####

func is_class(value: String): return value == "WanderState" or .is_class(value)
func get_class() -> String: return "WanderState"


#### BUILT-IN ####

func _ready() -> void:
	var __ = timer_node.connect("timeout", self, "_on_timer_timeout")
	__ = owner.connect("path_finished", self, "_on_path_finished")
	__ = Events.connect("light_activated", self, "_on_light_activated")

#### VIRTUALS ####

func enter_state():
	trigger_wait_time()

func exit_state():
	timer_node.stop()

func update(delta: float):
	if !owner.get_move_path().empty():
		owner.move(delta)


#### LOGIC ####


func trigger_wait_time():
	var rdm_variance = rand_range(-wait_time_variance, wait_time_variance)
	timer_node.start(average_wait_time + average_wait_time * rdm_variance)


func find_wander_path():
	var target_point := Vector2.INF
	
	while(!owner.level_node.is_position_walkable(target_point)):
		var dist_to_target = rand_range(wander_radius * 0.6, wander_radius)
		var rdm_angle = deg2rad(rand_range(0.0, 360.0))
		
		var dir = Vector2(cos(rdm_angle), sin(rdm_angle))
		target_point = owner.position + dir * dist_to_target
	
	### CHECK IF THE DESTINATION IS VALID ###
	
	Events.emit_signal("query_path", owner, owner.position, target_point)

#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_timer_timeout():
	if owner.get_state() == self:
		find_wander_path()


func _on_path_finished():
	if owner.get_state() == self:
		trigger_wait_time()


func _on_path_received(who: Actor, received_path: PoolVector2Array):
	if who == owner && owner.get_state() == self:
		owner.set_move_path(received_path)


func _on_light_activated(light: LightBase, active: bool):
	if owner.get_state() != self:
		return
	
	if active:
		if owner.is_light_source_visible(light):
			owner.seek(light)
