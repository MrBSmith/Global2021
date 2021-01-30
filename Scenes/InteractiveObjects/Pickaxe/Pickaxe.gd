extends InteractiveObject
class_name Pickaxe

export var effect_range : float = 10.0

onready var raycast = $RayCast2D
onready var statemachine = $StatesMachine

#### ACCESSORS ####

func is_class(value: String): return value == "Pickaxe" or .is_class(value)
func get_class() -> String: return "Pickaxe"

func set_state(value): statemachine.set_state(value)
func get_state() -> StateBase : return statemachine.get_state()
func get_state_name() -> String: return statemachine.get_state_name()

#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func equip(actor: Actor):
	
	var equipment_copy = self.duplicate()
	actor.add_child(equipment_copy)
	
	equipment_copy.set_state("Equiped")
	equipment_copy.get_node("StatesMachine/Equiped").set_actor(actor)
	queue_free()


func unequip():
	var actor = $StatesMachine/Equiped.get_actor()
	var equipment_copy = self.duplicate()
	actor.get_owner().add_child(equipment_copy)
	
	equipment_copy.set_state("Idle")
	equipment_copy.set_global_position(actor.get_global_position())
	
	queue_free()

#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_interact():
	if get_state_name() == "Equiped":
		get_state().interact()
	else:
		var bodies_array = $Area2D.get_overlapping_bodies()
		for body in bodies_array:
			if body is Player:
				get_state().interact(body)
