extends TileMap


enum Corridor {
	TOP,
	LEFT,
	RIGHT,
	BOTTOM,
}


const CORRIDOR_INDICES = {
	Corridor.TOP: 3,
	Corridor.LEFT: 1,
	Corridor.RIGHT: 2,
	Corridor.BOTTOM: 4
}

const BLOCKING_LAYER = 5


func set_passage(corridor: Corridor, enabled: bool) -> void:
	set_layer_enabled(CORRIDOR_INDICES[corridor], !enabled)


func open() -> void:
	set_layer_enabled(BLOCKING_LAYER, false)


func close() -> void:
	set_layer_enabled(BLOCKING_LAYER, true)

