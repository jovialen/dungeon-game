extends Node
class_name EditorOnlyNode


func _ready():
	print("deleting ", name)
	queue_free()
