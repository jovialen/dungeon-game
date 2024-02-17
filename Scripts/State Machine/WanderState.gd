extends State
class_name WanderState


@export var parent: CharacterBody2D
@export var wander_speed := 10.0
@export var walking_period_range := Vector2(1, 3)
@export var waiting_period_range := Vector2(1, 3)

var wander_dir := Vector2.ZERO
var wander_time := 0.0


func start():
	_random_wander()


func update(delta):
	if wander_time <= 0:
		_random_wander()
	wander_time -= delta
	
	consider_exit()


func physics_update(delta):
	if parent:
		parent.velocity = wander_dir * wander_speed
		parent.move_and_slide()


func consider_exit():
	pass


func _random_wander():
	if wander_dir == Vector2.ZERO:
		wander_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1))
		wander_time = randf_range(walking_period_range.x, walking_period_range.y)
	else:
		wander_dir = Vector2.ZERO
		wander_time = randf_range(waiting_period_range.x, waiting_period_range.y)
