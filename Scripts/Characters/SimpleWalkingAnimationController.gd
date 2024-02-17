extends AnimationTree


@export var parent: CharacterBody2D


func _process(delta):
	var is_idle = parent.velocity == Vector2.ZERO
	self["parameters/conditions/is_idle"] = is_idle
	self["parameters/conditions/is_moving"] = !is_idle
