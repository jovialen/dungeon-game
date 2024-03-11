extends Area2D
class_name NextLevelArea


@export var level_size_increase := Vector2(1, 1)


func _ready():
	connect("body_entered", _level_up)


func _level_up(body):
	get_node("/root/LevelData").level_size += level_size_increase
	get_node("/root/LevelData").level_num += 1
	get_tree().call_deferred("reload_current_scene")
