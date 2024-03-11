extends CharacterBody2D


@export var max_speed := 200
@export var acceleration := 200
@export var deceleration := 200

@onready var health = $Health


func _ready():
	health.connect("death", _on_player_death)


func _process(delta):
	_move(delta)
	
	if Input.is_action_pressed("primary_attack"):
		var enemies = get_tree().get_nodes_in_group("enemies")
		for enemy in enemies:
			if global_position.distance_to(enemy.global_position) < 100:
				enemy.queue_free()


func _move(delta):
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	dir = dir.normalized()
	var target_speed = dir * max_speed
	
	var weight = 1
	if target_speed.length() == 0:
		weight = delta * deceleration / 10
	else:
		weight = delta * acceleration / 10
		
	
	velocity.x = lerpf(velocity.x, target_speed.x, weight)
	velocity.y = lerpf(velocity.y, target_speed.y, weight)
	
	move_and_slide()


func _on_player_death():
	get_tree().reload_current_scene()
