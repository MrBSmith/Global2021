extends Node

class_name StateBase

onready var states_machine = get_parent()

#### Abstract base class for a State in a state machine ####

# Called when the current state of the state machine is set to this node
func enter_state():
	pass
	
# Called when the current state of the state machine is switched to another one
func exit_state():
	pass

# Called every frames, for real time behaviour
# Use a return "State_node_name" or return Node_reference to change the current state of the state machine at a given time
func update(_delta):
	pass
