extends StateBase
class_name SeekState

var light_source : LightBase = null setget set_light_source, get_light_source

#### ACCESSORS ####

func is_class(value: String): return value == "SeekState" or .is_class(value)
func get_class() -> String: return "SeekState"

func set_light_source(value: LightBase):
	if value != light_source:
		light_source = value
		
		if owner.get_state() == self && light_source != null:
			follow_light_source()

func get_light_source() -> LightBase: return light_source



#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("light_activated", self, "_on_light_activated")

#### VIRTUALS ####

func enter_state():
	follow_light_source()


func exit_state():
	set_light_source(null)


func update(delta: float):
	if !owner.get_move_path().empty():
		owner.move(delta)


#### LOGIC ####

func follow_light_source():
	var light_source_pos = light_source.get_global_position()
	Events.emit_signal("query_path", owner, owner.get_position(), light_source_pos)



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_path_received(who: Actor, received_path: PoolVector2Array):
	if who == owner && owner.get_state() == self:
		owner.set_move_path(received_path)


func _on_light_activated(light: LightBase, active: bool):
	if owner.get_state() != self:
		return
	
	if active:
		if owner.is_light_source_visible(light):
			set_light_source(light)
	elif light == light_source:
		owner.set_state("Wander")
