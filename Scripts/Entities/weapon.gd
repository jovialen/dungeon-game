extends Node2D


@onready var animation_tree = $AnimationTree


func _ready():
	animation_tree.connect("animation_finished", _animation_finished)


func _animation_finished(algo_extrano):
	queue_free()

