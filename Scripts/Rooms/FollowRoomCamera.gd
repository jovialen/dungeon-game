extends Camera2D


@export_category("Camera Movement")
@export var movement_speed := 1.0
@export var initial_room : Room

@onready var current_room := initial_room


func _ready():
	get_parent().connect("ready", _parent_ready)


func _process(delta):
	position.x = move_toward(position.x, current_room.position.x, delta * movement_speed)
	position.y = move_toward(position.y, current_room.position.y, delta * movement_speed)


func _parent_ready():
	var rooms = get_tree().get_nodes_in_group("rooms")
	for room in rooms:
		room.connect("player_trapped", _player_trapped)


func _player_trapped(room):
	current_room = room
