extends State
class_name StunnedState

@export var duration := 1.0
@export var next_state: State
@export var parent: CharacterBody2D
@export var stop_velocity := true
@export var breaking_power := 10.0

var time := 0.0


func update(delta):
	time += delta
	if time >= duration:
		emit_signal("change_state", next_state.name)


func physics_update(delta):
	if parent and stop_velocity:
		parent.velocity.x = lerp(parent.velocity.x, 0.0, delta * breaking_power)
		parent.velocity.y = lerp(parent.velocity.y, 0.0, delta * breaking_power)
