extends CharacterBody2D


signal health_changed


@export_category("Movement")
@export var max_speed := 200
@export var acceleration := 200
@export var deceleration := 200

@export_category("Weapons")
@export var weapon : PackedScene = preload("res://Scenes/Entitites/weapon.tscn")
@export var weapon_cooldown := 0.4

@onready var health = $Health

var weapon_cooldown_timer := 0.0


func _ready():
	health.connect("death", _on_player_death)
	health.connect("health_changed", func(h): health_changed.emit(h))


func _process(delta):
	_move(delta)
	
	weapon_cooldown_timer += delta
	if Input.is_action_just_pressed("primary_attack") and \
		weapon_cooldown_timer > weapon_cooldown:
		weapon_cooldown_timer = 0.0
		_attack()


func get_max_health() -> int:
	return health.max_health


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


func _attack():
	var attack = weapon.instantiate()
	
	var dir = Input.get_vector("attack_left", "attack_right", "attack_up", "attack_down")
	if dir == Vector2(0, 0):
		attack.rotation = _angle_to_mouse()
	else:
		attack.rotation = dir.angle() + PI/2
	add_child(attack)


func _angle_to_mouse() -> float:
	var mouse_position = get_global_mouse_position()
	var angle_to_mouse = global_position.angle_to_point(mouse_position) + PI/2
	return angle_to_mouse


func _on_player_death():
	get_node("/root/LevelData").reset()
	get_tree().call_deferred("reload_current_scene")
