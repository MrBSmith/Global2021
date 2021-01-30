extends StateBase
class_name PickaxeIdleState

#### ACCESSORS ####

func is_class(value: String): return value == "PickaxeIdleState" or .is_class(value)
func get_class() -> String: return "PickaxeIdleState"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func interact(actor: Actor):
	owner.equip(actor)

#### INPUTS ####



#### SIGNAL RESPONSES ####
