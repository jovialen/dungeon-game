extends TileMap


@export var blocking_layer_index := 2

@export_category("Corridors")
@export var top := false
@export var bottom := false
@export var left := false
@export var right := false

@onready var trap = $Trap


func _ready():
	trap.connect("trapped", _trapped)


func _process(delta):
	var any_enemies = len(get_tree().get_nodes_in_group("enemies")) > 0
	if !any_enemies:
		call_deferred("set_layer_enabled", blocking_layer_index, false)


func _trapped():
	call_deferred("set_layer_enabled", blocking_layer_index, true)
	for child in get_children():
		if child is RoomSpawner:
			child.spawn()


func matches(t, b, l, r):
	return t == top && b == bottom && l == left && r == right
