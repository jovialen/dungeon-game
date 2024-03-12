extends TileMap
class_name Room


signal player_entered(Node2D)
signal room_cleared


enum Corridor {
	TOP,
	LEFT,
	RIGHT,
	BOTTOM,
}


const REVERSE_CORRIDOR = {
	Corridor.TOP: Corridor.BOTTOM,
	Corridor.BOTTOM: Corridor.TOP,
	Corridor.LEFT: Corridor.RIGHT,
	Corridor.RIGHT: Corridor.LEFT
}

const CORRIDOR_OFFSETS = {
	Corridor.TOP: Vector2(0, 1),
	Corridor.BOTTOM: Vector2(0, -1),
	Corridor.LEFT: Vector2(-1, 0),
	Corridor.RIGHT: Vector2(1, 0)
}

const CORRIDOR_INDICES = {
	Corridor.TOP: 3,
	Corridor.LEFT: 1,
	Corridor.RIGHT: 2,
	Corridor.BOTTOM: 4
}

const BLOCKING_LAYER = 5


@onready var area_2d = $"Player Area"
@onready var enemy_area = $"Enemies Area"
@onready var animation_tree = $AnimationTree

var cleared := false
var closed := false


func _ready():
	area_2d.connect("body_entered", _player_entered)
	animation_tree.connect("animation_finished", _animation_finished)
	
	open()


func _process(delta):
	if closed:
		cleared = len(enemy_area.get_overlapping_bodies()) == 0
		
		if cleared:
			_clear_room()


func set_passage(corridor: Corridor, enabled: bool) -> void:
	set_layer_enabled(CORRIDOR_INDICES[corridor], !enabled)


func open() -> void:
	closed = false
	animation_tree["parameters/conditions/room_closed"] = false
	animation_tree["parameters/conditions/room_opened"] = true
	_enable_enemies(false)


func close() -> void:
	closed = true
	animation_tree["parameters/conditions/room_closed"] = true
	animation_tree["parameters/conditions/room_opened"] = false
	_enable_enemies(true)


func reset() -> void:
	open()
	cleared = false
	if player_in_room():
		_player_entered(get_tree().get_first_node_in_group("player"))


func player_in_room() -> bool:
	return area_2d.has_overlapping_bodies()


func _player_entered(player: Node2D):
	player_entered.emit(player)
	if not cleared:
		close()


func _clear_room():
	open()
	cleared = true
	room_cleared.emit()


func _enable_enemies(enable: bool) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.set_process(enable)
		enemy.set_physics_process(enable)


func _animation_finished(ignore):
	set_layer_enabled(BLOCKING_LAYER, closed)
