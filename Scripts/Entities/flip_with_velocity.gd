extends Sprite2D


@export var mover : CharacterBody2D


func _process(delta):
	if mover:
		if mover.velocity.length_squared() != 0:
			flip_h = mover.velocity.x < 0
