extends Node
class_name StateMachine


signal state_changed(old_state, new_state)


@export var initial_state: State

var states: Dictionary
@onready var current_state := initial_state.name.to_lower()


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.connect("change_state", change_state)
	
	states[current_state].start()


func _process(delta):
	states[current_state].update(delta)


func _physics_process(delta):
	states[current_state].physics_update(delta)


func change_state(state: String):
	state = state.to_lower()
	
	if state == current_state:
		return
	
	if state not in states:
		print("error: state " + state + " does not exist")
		return
	
	var old_state = current_state
	current_state = state
	
	states[old_state].stop()
	states[current_state].start()
	
	print("state changed from " + old_state + " to " + current_state)
	emit_signal("state_changed", old_state, current_state)
