extends CharacterBody2D


@onready var health = $Health

@onready var stun_state = $FiniteStateMachine/StunState
@onready var finite_state_machine = $FiniteStateMachine


func _ready():
	health.connect("damaged", _on_damaged)
	health.connect("death", _on_death)


func _process(delta):
	move_and_slide()


func _on_damaged(points):
	finite_state_machine.set_state(stun_state)


func _on_death():
	queue_free()
