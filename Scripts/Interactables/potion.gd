extends Node2D


@onready var area_2d = $Area2D


func _ready():
	area_2d.connect("body_entered", _on_player_contact)


func _on_player_contact(player):
	queue_free()
