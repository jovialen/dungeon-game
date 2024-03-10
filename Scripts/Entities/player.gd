extends CharacterBody2D


@export var speed := 300


func _ready():
	pass


func _process(delta):
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = dir * speed
	move_and_slide()
