extends Actor
class_name Enemy

onready var statemachine = $StatesMachine
onready var chase_state = $StatesMachine/Chase
onready var seek_state = $StatesMachine/Seek
onready var detection_area = $DetectionArea
onready var hitbox = $HitBox

export var debug : bool = false

var move_path := PoolVector2Array()

var currently_visible : bool = false setget set_currently_visible, get_currently_visible

signal path_finished()

#### ACCESSORS ####

func is_class(value: String): return value == "Enemy" or .is_class(value)
func get_class() -> String: return "Enemy"

func set_move_path(value: PoolVector2Array): move_path = value
func get_move_path() -> PoolVector2Array: return move_path

func set_state(value): statemachine.set_state(value)
func get_state() -> StateBase : return statemachine.get_state()
func get_state_name() -> String: return statemachine.get_state_name()

func set_currently_visible(value: bool): 
	currently_visible = value
	set_visible(currently_visible)

func get_currently_visible() -> bool: return currently_visible


#### BUILT-IN ####

func _ready() -> void:
	set_visible(false)
	
	var __ = Events.connect("send_path", $StatesMachine/Wander, "_on_path_received")
	__ = Events.connect("send_path", chase_state, "_on_path_received")
	__ = Events.connect("send_path", seek_state, "_on_path_received")
	
	__ = Events.connect("light_activated", self, "_on_light_activated")
	__ = Events.connect("body_entered_light", self, "_on_body_entered_light")
	__ = Events.connect("body_exited_light", self, "_on_body_exited_light")
	
	__ = detection_area.connect("area_entered", self, "_on_area_entered_detection_area")
	__ = detection_area.connect("body_entered", self, "_on_body_entered_detection_area")
	__ = detection_area.connect("body_exited", self, "_on_body_exited_detection_area")
	
	__ = hitbox.connect("body_entered", self, "_on_body_entered")
	
	if debug:
		__ = statemachine.connect("state_changed", $StateLabel, "_on_state_changed")

#### VIRTUALS ####

func rotate_sprites():
	var dir = get_direction()
	
	if dir.y < -0.5:
		$Eyes.set_modulate(Color(0.0, 0.0, 0.0, 0.3))
	else:
		$Eyes.set_modulate(Color.white)

	$Eyes.set_flip_h(dir.x < 0)
	$Sprite.set_flip_h(dir.x < 0)

#### LOGIC ####

func update_visibility(exeption: LightBase = null):
	var lights_array = get_tree().get_nodes_in_group("LightSource")
	
	for light in lights_array:
		if !light.is_active() or light == exeption: continue
		
		if light.is_body_visible(self):
			set_currently_visible(true)
			return
	
	set_currently_visible(false)


func move(delta: float):
	var target = move_path[0]
	var dir = position.direction_to(target)
	if dir != Vector2.ZERO:
		set_direction(dir)
	
	var real_speed = speed * delta
	var dist_to_target = position.distance_to(target)
	
	if real_speed > dist_to_target:
		real_speed = dist_to_target
	
	var velocity = dir * real_speed
	position += velocity
	
	if position.distance_to(target) < 2.0:
		position = target
		move_path.remove(0)
		if move_path.empty():
			emit_signal("path_finished")


func seek(light_source: LightBase):
	seek_state.set_light_source(light_source)
	set_state(seek_state)


func chase(target: Actor):
	chase_state.set_target(target)
	set_state(chase_state)


func is_light_source_visible(light_source: LightBase) -> bool:
	for area in detection_area.get_overlapping_areas():
		if area == light_source:
			return true
	return false

#### INPUTS ####

 
#### SIGNAL RESPONSES ####

func _on_body_entered(body: PhysicsBody2D):
	if body is Player:
		Events.emit_signal("gameover")

func _on_body_entered_light(_light: LightBase, body: PhysicsBody2D):
	if body == self:
		update_visibility()


func _on_body_exited_light(light: LightBase, body: PhysicsBody2D):
	if body == self:
		update_visibility(light)


func _on_light_activated(_light_source: LightBase, _activate: bool):
	update_visibility()


func _on_body_entered_detection_area(body: PhysicsBody2D):
	if body is Player:
		chase(body)


func _on_body_exited_detection_area(body: PhysicsBody2D):
	if body is Player:
		set_state("Wander")


func _on_area_entered_detection_area(area: Area2D):
	if !area is LightBase:
		return

	if get_state_name() == "Wander" && area.is_active():
		seek(area)
