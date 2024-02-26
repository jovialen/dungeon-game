extends Node2D

@export var orbit_distance := 5.0


func _process(delta):
	var mouse = get_viewport().get_mouse_position()
	var this = get_parent().get_global_transform_with_canvas().get_origin()
	var angle_to_mouse = this.angle_to_point(mouse)
	
	position.x = cos(angle_to_mouse) * orbit_distance
	position.y = sin(angle_to_mouse) * orbit_distance
	rotation = angle_to_mouse + PI / 2
