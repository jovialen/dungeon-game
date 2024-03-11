extends Sprite2D


func _ready():
	# This will break after level 9, but no-one is ever going to get that far, so its fine.
	region_rect.position.x = get_node("/root/LevelData").level_num * region_rect.size.x
