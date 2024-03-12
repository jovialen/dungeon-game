extends HBoxContainer

var player : Node2D = null

const HEART = preload("res://Scenes/GUI/heart.tscn")
const HEART_OUTLINE = preload("res://Scenes/GUI/heart_outline.tscn")


func _ready():
	player = get_tree().get_first_node_in_group("player")
	for i in player.get_max_health():
		add_child(HEART.instantiate())
	player.connect("health_changed", _on_player_health_change)


func _on_player_health_change(health):
	for child in get_children():
		child.queue_free()
	
	for i in health:
		call_deferred("add_child", HEART.instantiate())
	for i in player.get_max_health() - health:
		call_deferred("add_child", HEART_OUTLINE.instantiate())
