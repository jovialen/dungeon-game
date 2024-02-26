extends Area2D

@export var damage := 1

@onready var animation_player = $AnimationPlayer


func _ready():
	connect("body_entered", _body_entered)


func _body_entered(node):
	print("hit " + node.name)
	if node.is_in_group("enemies"):
		node.hit(damage)
	elif node.is_in_group("interactable"):
		node.interact()


func _input(event):
	if event.is_action_pressed("primary_attack"):
		print("attacking")
		animation_player.current_animation = "SwingWeapon"
