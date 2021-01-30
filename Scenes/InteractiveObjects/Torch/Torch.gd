extends InteractiveObject
class_name Torch

onready var fire = $Fire

export var fire_duration : float = 5.0
 
var on_fire : bool = false setget set_on_fire, is_on_fire

#### ACCESSORS ####

func is_class(value: String): return value == "Torch" or .is_class(value)
func get_class() -> String: return "Torch"

func set_on_fire(value: bool):
	if value == on_fire:
		return
	
	on_fire = value
	$Fire/Light.set_active(on_fire)
	$Fire/Particles2D.set_emitting(on_fire)
	
	if on_fire:
		$Fire/Timer.start(fire_duration)

func is_on_fire() -> bool: return on_fire


#### BUILT-IN ####

func _ready() -> void:
	$Fire/Light.set_visible(on_fire)
	$Fire/Particles2D.set_emitting(on_fire)
	
	var __ = Events.connect("try_to_fire", self, "_on_try_to_fire")
	__ = $Fire/Timer.connect("timeout", self, "_on_fire_timer_timeout")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_try_to_fire():
	var bodies_array = $Area2D.get_overlapping_bodies()
	for body in bodies_array:
		if body is Player:
			set_on_fire(true)


func _on_fire_timer_timeout():
	set_on_fire(false)
