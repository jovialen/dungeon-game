extends Area2D
class_name HealthArea


@export var health : Health
@export var hurters  : Array[String] = [ "enemies" ]
@export var healpers : Array[String] = []
@export var fragility := 1
@export var resilience := 1

@export var hurt_sound : AudioStreamPlayer2D
@export var heal_sound : AudioStreamPlayer2D


func _ready():
	connect("body_entered", _on_health_area_entered)
	connect("area_entered", _on_health_area_entered)


func _on_health_area_entered(node):
	print(node.name)
	
	for hurt in hurters:
		if node.is_in_group(hurt):
			health.damage(fragility)
			if hurt_sound:
				hurt_sound.play()
			break
	
	for healper in healpers:
		if node.is_in_group(healper):
			health.heal(resilience)
			if heal_sound:
				heal_sound.play()
			break
