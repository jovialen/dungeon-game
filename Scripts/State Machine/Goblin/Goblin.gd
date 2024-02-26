extends CharacterBody2D


@export var knockback_speed := 1.0

@onready var state_machine = $"State Machine"
@onready var damage_area_2d = $DamageArea2D


func _ready():
	damage_area_2d.connect("damage_done", damage_done)
	state_machine.connect("state_changed", state_changed)


func _physics_process(delta):
	move_and_slide()


func state_changed(from, to):
	var is_stunned = to == "stunned"
	set_collision_mask_value(2, !is_stunned)
	set_collision_layer_value(2, !is_stunned)
	damage_area_2d.set_deferred("monitoring", !is_stunned)


func damage_done(damage):
	state_machine.change_state("stunned")
	var vector = damage["to"].position - damage["by"].position
	velocity = -vector * knockback_speed
