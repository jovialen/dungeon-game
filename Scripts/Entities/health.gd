extends Node
class_name Health


signal health_changed
signal death


@export var max_health := 10

@onready var current_health := max_health


func set_health(health: int):
	print("health changed to ", health)
	
	current_health = clamp(health, 0, max_health)
	health_changed.emit(current_health)
	
	if current_health == 0:
		print("death!")
		death.emit()


func is_dead() -> bool:
	return current_health == 0


func is_damaged() -> bool:
	return current_health != max_health


func damage(points: int):
	set_health(current_health - points)


func heal(points: int):
	set_health(current_health + points)
