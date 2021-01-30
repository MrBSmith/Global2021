extends Actor
class_name Player

onready var lighter = $Lighter

var direction := Vector2.UP setget set_direction, get_direction

var v_movement : float = 0.0
var h_movement : float = 0.0

var light_on : bool = true setget set_light_on, is_light_on

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"

func set_light_on(value: bool):
	light_on = value
	lighter.set_visible(light_on)

func is_light_on() -> bool: return light_on

func set_direction(value: Vector2): direction = value
func get_direction() -> Vector2: return direction

#### BUILT-IN ####


func _physics_process(_delta: float) -> void:
	var move_dir = Vector2(v_movement, h_movement).normalized()
	if move_dir != Vector2.ZERO:
		set_direction(move_dir)
	
	var velocity = move_dir * speed
	var __ = move_and_slide(velocity)

 

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####

func _input(_event: InputEvent) -> void:
	v_movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	h_movement = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if Input.is_action_just_pressed("ui_accept"):
		Events.emit_signal("interact")

#### SIGNAL RESPONSES ####
