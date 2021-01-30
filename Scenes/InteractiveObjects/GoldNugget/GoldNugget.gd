extends InteractiveObject
class_name GoldNugget

#### ACCESSORS ####

func is_class(value: String): return value == "GoldNugget" or .is_class(value)
func get_class() -> String: return "GoldNugget"


#### BUILT-IN ####

func _ready() -> void:
	var __ = $FollowArea.connect("body_entered", self, "_on_follow_area_body_entered")
	__ = $Area2D.connect("body_entered", self, "_on_collect_area_body_entered")

#### VIRTUALS ####



#### LOGIC ####

func follow(target: Node2D):
	$StatesMachine/Follow.set_target(target)

func collect():
	Events.emit_signal("gold_collected")
	queue_free()

#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_follow_area_body_entered(body: PhysicsBody2D):
	if body is Player:
		follow(body)

func _on_collect_area_body_entered(body: PhysicsBody2D):
	if body is Player:
		collect()
