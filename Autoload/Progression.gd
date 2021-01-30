extends Node

var gold : int = 0 setget set_gold, get_gold

#### ACCESSORS ####

func set_gold(value: int):
	if value != gold:
		gold = value
		Events.emit_signal("gold_amount_changed", gold)

func get_gold() -> int: return gold

#### BUILT-IN ####

func _ready() -> void:
	var __ = Events.connect("gold_collected", self, "_on_gold_collected")

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_gold_collected():
	set_gold(get_gold() + 1)
