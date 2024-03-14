extends AudioStreamPlayer2D


var player
var played := false


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _process(delta):
	if global_position.distance_to(player.global_position) < 180 and not played:
		play()
		played = true
