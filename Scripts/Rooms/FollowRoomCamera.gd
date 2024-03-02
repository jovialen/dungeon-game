extends Camera2D


@export_category("Camera Movement")
@export var movement_speed := 1.0

@onready var current_room : Room = null


func _ready():
	get_parent().connect("ready", _parent_ready)


func _process(delta):
	if current_room == null:
		return
	
	global_position.x = move_toward(global_position.x, current_room.global_position.x, delta * movement_speed)
	global_position.y = move_toward(global_position.y, current_room.global_position.y, delta * movement_speed)


func _parent_ready():
	var rooms = get_tree().get_nodes_in_group("rooms")
	print(str(len(rooms)) + " rooms spawned")
	for room in rooms:
		room.connect("player_trapped", _player_trapped)


func _player_trapped(room):
	print("camera moving to new room")
	current_room = room
