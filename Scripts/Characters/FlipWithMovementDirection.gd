extends Sprite2D


@export var parent : CharacterBody2D
@export var reverse := false


func _process(delta):
	if parent:
		# No need to mess with the direction if we're not moving
		if parent.velocity.x == 0:
			return
		
		var moving_left = parent.velocity.x < 0
		if reverse:
			flip_h = moving_left
		else:
			flip_h = not moving_left
