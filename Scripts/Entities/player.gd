extends CharacterBody2D


@export var max_speed := 200
@export var acceleration := 200
@export var deceleration := 200


func _ready():
	pass


func _process(delta):
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	dir = dir.normalized()
	var target_speed = dir * max_speed
	
	var weight = 1
	if target_speed.length() == 0:
		weight = delta * deceleration / 10
	else:
		weight = delta * acceleration / 10
		
	
	velocity.x = lerpf(velocity.x, target_speed.x, weight)
	velocity.y = lerpf(velocity.y, target_speed.y, weight)
	
	move_and_slide()
