extends TileMap
class_name Room


signal player_entered(Node2D)


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


@onready var area_2d = $Area2D


func _ready():
	area_2d.connect("body_entered", _player_entered)


func set_passage(corridor: Corridor, enabled: bool) -> void:
	set_layer_enabled(CORRIDOR_INDICES[corridor], !enabled)


func open() -> void:
	set_layer_enabled(BLOCKING_LAYER, false)


func close() -> void:
	set_layer_enabled(BLOCKING_LAYER, true)


func _player_entered(player: Node2D):
	player_entered.emit(player)
