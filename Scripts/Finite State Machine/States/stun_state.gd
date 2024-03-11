extends State
class_name StunState


@export var stunned : CharacterBody2D
@export var stun_speed := 200
@export var stun_time := 0.5
@export var next_state : State

var timer := 0.0


func start():
	timer = 0.0
	stunned.velocity = -stunned.velocity


func _process(delta):
	stunned.velocity.x = move_toward(stunned.velocity.x, 0, delta * stun_speed)
	stunned.velocity.y = move_toward(stunned.velocity.y, 0, delta * stun_speed)
	
	timer += delta
	if timer > stun_time:
		change_state.emit(next_state)
