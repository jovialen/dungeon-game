extends Node
class_name Health


signal health_changed
signal death
signal healed
signal damaged


@export var max_health := 10
@export var grace_period := 0.5

@onready var current_health := max_health
@onready var last_hit := 0.0


func _process(delta):
	last_hit += delta


func set_health(health: int):
	if health < current_health and last_hit < grace_period:
		print("attempt to damage during grace period stopped")
		return
	
	print("health changed to ", health)
	last_hit = 0
	
	var old_health = current_health
	current_health = clamp(health, 0, max_health)
	health_changed.emit(current_health)
	
	if old_health > current_health:
		damaged.emit(old_health - current_health)
	elif old_health < current_health:
		healed.emit(current_health - old_health)
	
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
