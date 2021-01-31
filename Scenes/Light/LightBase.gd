extends Area2D
class_name LightBase

export var active : bool = false setget set_active, is_active

#### ACCESSORS ####

func is_class(value: String): return value == "LightBase" or .is_class(value)
func get_class() -> String: return "LightBase"

func set_active(value: bool):
	if value == active:
		return
	
	active = value
	set_visible(value)
	Events.emit_signal("light_activated", self, active)
	update_fog_tiles()

func is_active() -> bool : return active

#### BUILT-IN ####

func _ready() -> void:
	var _err = connect("area_entered", self, "_on_area_entered")
	_err = connect("area_exited", self, "_on_area_exited")
	
	_err = connect("body_entered", self, "_on_body_entered")
	_err = connect("body_exited", self, "_on_body_exited")

#### VIRTUALS ####



#### LOGIC ####

func update_fog_tiles():
	for area in get_overlapping_areas():
		if !area is FogTile:
			continue
		
		if is_active():
			area.set_state("visible")
		else:
			area.set_state("not_visible")


func is_body_visible(body: PhysicsBody2D) -> bool:
	var bodies_in_area = get_overlapping_bodies()
	return body in bodies_in_area



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_area_entered(area: Area2D):
	if area is FogTile && is_active():
		area.set_state("visible")


func _on_area_exited(area: Area2D):
	if area is FogTile && is_active():
		area.set_state("not_visible")


func _on_body_entered(body: PhysicsBody2D):
	if body is Actor:
		Events.emit_signal("body_entered_light", self, body)


func _on_body_exited(body: PhysicsBody2D):
	if body is Actor:
		Events.emit_signal("body_exited_light", self, body)
