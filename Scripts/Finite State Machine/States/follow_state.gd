extends State
class_name FollowState


@export var follower : CharacterBody2D = null
@export var max_speed := 200
@export var acceleration := 200
@export var deceleration := 200

@export var target : Node2D = null


func _process(delta):
	if not target or not follower:
		return
		
	var dir = target.global_position - follower.global_position
	dir = dir.normalized()
	var target_speed = dir * max_speed
	
	var weight = 1
	if target_speed.length() == 0:
		weight = delta * deceleration / 10
	else:
		weight = delta * acceleration / 10
		
	
	follower.velocity.x = lerpf(follower.velocity.x, target_speed.x, weight)
	follower.velocity.y = lerpf(follower.velocity.y, target_speed.y, weight)
	
	follower.move_and_slide()


func set_target(new_target: Node2D):
	target = new_target
