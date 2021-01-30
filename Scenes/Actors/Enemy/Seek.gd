extends StateBase
class_name SeekState

var light_source : LightBase = null setget set_light_source, get_light_source

#### ACCESSORS ####

func is_class(value: String): return value == "SeekState" or .is_class(value)
func get_class() -> String: return "SeekState"

func set_light_source(value: LightBase): light_source = value
func get_light_source() -> LightBase: return light_source



#### BUILT-IN ####



#### VIRTUALS ####

func enter_state():
	var light_source_pos = light_source.get_global_position()
	Events.emit_signal("query_path", owner, owner.get_position(), light_source_pos)


func exit_state():
	set_light_source(null)

func update(delta: float):
	if !owner.get_move_path().empty():
		owner.move(delta)


#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_path_received(who: Actor, received_path: PoolVector2Array):
	if who == owner && owner.get_state() == self:
		owner.set_move_path(received_path)
