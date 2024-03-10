extends Camera2D


func _ready():
	var rooms = get_tree().get_nodes_in_group("rooms")
	for room in rooms:
		room.connect("player_entered", func(player): _room_entered(room))



func _room_entered(room: Node2D) -> void:
	global_position = room.global_position
