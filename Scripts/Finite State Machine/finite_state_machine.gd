extends Node
class_name FiniteStateMachine


signal state_changed


@export var initial_state : State = null

@onready var current_state

var states : Array[State] = []



func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.set_process(false)
			child.set_physics_process(false)
			child.connect("change_state", set_state)
	
	set_state(initial_state)


func set_state(state: State):
	if not state:
		print("cannot set state to null")
		return
	elif state not in states:
		print("state ", state.name, " is not in state machine states")
		return
	
	print("setting state to ", state.name)
	
	if current_state:
		current_state.stop()
		current_state.set_process(false)
		current_state.set_physics_process(false)
	
	var old_state = current_state
	current_state = state
	
	current_state.set_process(true)
	current_state.set_physics_process(true)
	current_state.start()
	
	state_changed.emit(old_state, current_state)
