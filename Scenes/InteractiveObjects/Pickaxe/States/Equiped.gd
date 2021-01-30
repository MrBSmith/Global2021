extends StateBase
class_name PickaxeEquipedState

var actor : Actor = null setget set_actor, get_actor

#### ACCESSORS ####

func is_class(value: String): return value == "PickaxeEquipedState" or .is_class(value)
func get_class() -> String: return "PickaxeEquipedState"

func set_actor(value: Actor): actor = value
func get_actor() -> Actor: return actor

#### BUILT-IN ####



#### VIRTUALS ####

func enter_state():
	owner.set_position(Vector2.ZERO)


func interact():
	var actor_dir = actor.get_direction()
	var raycast : RayCast2D = owner.raycast
	raycast.set_cast_to(actor_dir * owner.effect_range)
	raycast.set_enabled(true)
	
	raycast.force_raycast_update()
	var collider = raycast.get_collider()
	
	if collider is TileMap:
		var col_point = raycast.get_collision_point()
		var cell = collider.world_to_map(col_point + (actor_dir * 2))
		
		Events.emit_signal("damage_tile", cell)


#### LOGIC ####



#### INPUTS ####

func _input(_event: InputEvent) -> void:
	if owner.get_state() == self && Input.is_action_just_pressed("ui_select"):
		owner.unequip()

#### SIGNAL RESPONSES ####
