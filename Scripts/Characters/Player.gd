extends CharacterBody2D
class_name Player


@export var SPEED := 100.0

@onready var health = $Health


func _ready():
	health.connect("died", died)


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func died():
	print("player died")
	get_tree().call_deferred("reload_current_scene")


func hurt(points):
	print("player damaged ", points, " points")
	health.damage(points)


func heal(points):
	health.heal(points)
