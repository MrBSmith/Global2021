extends Control
class_name HUD

onready var gold_label = $VBoxContainer/GoldLabel

#### ACCESSORS ####

func is_class(value: String): return value == "HUD" or .is_class(value)
func get_class() -> String: return "HUD"


#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("gold_amount_changed", self, "_on_gold_amount_changed")

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_gold_amount_changed(amount: int):
	$VBoxContainer/GoldLabel.set_text("Gold: " + String(amount) + "/" + String(owner.gold_objective))
