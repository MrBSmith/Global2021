extends StateBase
class_name Chase

export var update_target_path_cooldown : float = 0.2 
var target : Actor = null setget set_target, get_target

#### ACCESSORS ####

func is_class(value: String): return value == "Chase" or .is_class(value)
func get_class() -> String: return "Chase"

func set_target(value: Actor): target = value
func get_target() -> Actor: return target

#### BUILT-IN ####

func _ready() -> void:
	var __ = $Timer.connect("timeout", self, "_on_timer_timeout")

#### VIRTUALS ####

func enter_state():
	update_path()
	$Timer.start(update_target_path_cooldown)


func exit_state():
	$Timer.stop()
	set_target(null)


func update(delta: float):
	if !owner.get_move_path().empty():
		owner.move(delta)


#### LOGIC ####

func update_path():
	var target_pos = target.get_position()
	
	Events.emit_signal("query_path", owner, owner.get_position(), target_pos)


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_timer_timeout():
	if owner.get_state() == self:
		update_path()


func _on_path_received(who: Actor, received_path: PoolVector2Array):
	if who == owner && owner.get_state() == self:
		owner.set_move_path(received_path)
