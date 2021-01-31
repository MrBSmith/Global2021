extends Actor
class_name Player

onready var lighter = $Lighter
onready var camera = $Camera2D

export var debug := false

var direction := Vector2.UP setget set_direction, get_direction

var v_movement : float = 0.0
var h_movement : float = 0.0

#### ACCESSORS ####

func is_class(value: String): return value == "Player" or .is_class(value)
func get_class() -> String: return "Player"

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
	
#	if Input.is_action_just_pressed("toggle_lighter"):
#		$Lighter.set_active(!$Lighter.is_active())
	
	### DEBUG ###
	if debug && Input.is_action_just_pressed("debug_dezoom"):
		var zoom = camera.get_zoom()
		if zoom == Vector2.ONE:
			camera.set_zoom(Vector2(2, 2))
		else: 
			camera.set_zoom(Vector2.ONE)

#### SIGNAL RESPONSES ####
