extends Node2D
class_name RoomSpawner


@export var enemy : PackedScene
@export var count := 1


func spawn():
	if enemy.can_instantiate():
		print("spawning " + str(count) + " enemies")
		for i in count:
			var node = enemy.instantiate()
			node.position.x = randf_range(-5, 5)
			node.position.y = randf_range(-5, 5)
			call_deferred("add_child", node)
