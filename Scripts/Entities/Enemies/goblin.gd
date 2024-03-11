extends CharacterBody2D


@onready var health = $Health


func _ready():
	health.connect("death", _on_death)


func _process(delta):
	move_and_slide()


func _on_death():
	queue_free()
