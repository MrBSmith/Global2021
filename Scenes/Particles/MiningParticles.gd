extends Particles2D
class_name MiningParticle

#### ACCESSORS ####

func is_class(value: String): return value == "MiningParticle" or .is_class(value)
func get_class() -> String: return "MiningParticle"


#### BUILT-IN ####

func _ready() -> void:
	set_emitting(true)
	var __ = $Timer.connect("timeout", self, "_on_timer_timeout")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_timer_timeout():
	queue_free()
