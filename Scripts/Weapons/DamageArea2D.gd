extends Area2D
class_name DamageArea2D


signal damage_done(damage)


@export var damage := 1


func _ready():
	connect("body_entered", _body_entered)


func _body_entered(body: Node2D):
	body.hurt(damage)
	emit_signal("damage_done", {
		"body": body,
		"damage": damage
	})
