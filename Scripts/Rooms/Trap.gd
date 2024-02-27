extends Area2D
class_name Trap


signal trapped


func _ready():
	connect("body_entered", _body_entered)


func _body_entered(node):
	print("trap activated")
	set_deferred("monitoring", false)
	emit_signal("trapped")
