extends Node
class_name Health


signal health_changed(health)
signal died


@export var max_health := 10

@onready var current_health := max_health : set = _set_health
var has_died := false


func damage(points: int):
	current_health -= points


func heal(points: int):
	has_died = false
	current_health += points


func is_damaged():
	return current_health < max_health


func _set_health(value):
	var prev_health = current_health
	current_health = clamp(value, 0, max_health)
	
	emit_signal("health_changed", {
		"current": current_health,
		"previous": prev_health,
		"max": max_health,
		"is_heal": current_health > prev_health,
		"percent": float(current_health) / float(max_health),
	})
	
	if current_health == 0 and not has_died:
		has_died = true
		emit_signal("died")
