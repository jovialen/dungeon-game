extends Sprite2D


@export var mover : CharacterBody2D
@export var flipped := false


func _process(delta):
	if mover:
		if mover.velocity.length_squared() != 0:
			flip_h = mover.velocity.x < 0
			if flipped:
				flip_h = !flip_h
