extends Node2D
class_name MazeGenerator


@export var size := Vector2(3, 3)
@export var room_map := {
	"B": [preload("res://Scenes/Rooms/Room B.tscn")],
	"BL": [preload("res://Scenes/Rooms/Room BL.tscn")],
	"BR": [preload("res://Scenes/Rooms/Room BR.tscn")],
	"BLR": [preload("res://Scenes/Rooms/Room BRL.tscn")],
	"L": [preload("res://Scenes/Rooms/Room L.tscn")],
	"R": [preload("res://Scenes/Rooms/Room R.tscn")],
	"LR": [preload("res://Scenes/Rooms/Room RL.tscn")],
	"T": [preload("res://Scenes/Rooms/Room T.tscn")],
	"TB": [preload("res://Scenes/Rooms/Room TB.tscn")],
	"TBL": [preload("res://Scenes/Rooms/Room TBL.tscn")],
	"TBR": [preload("res://Scenes/Rooms/Room TBR.tscn")],
	"TBLR": [preload("res://Scenes/Rooms/Room TBRL.tscn")],
	"TL": [preload("res://Scenes/Rooms/Room TL.tscn")],
	"TR": [preload("res://Scenes/Rooms/Room TR.tscn")],
	"TLR": [preload("res://Scenes/Rooms/Room TRL.tscn")]
}
@export var room_size := Vector2(224, 224)


func _ready():
	# Make empty maze
	var grid = []
	for x in size.x:
		grid.append([])
		for y in size.y:
			grid[x].append([])
	
	# Generate maze corridors
	randomize()
	grid = _recursive_backtracking(grid, Vector2(0, 0))
	
	# Spawn maze rooms
	for x in size.x:
		for y in size.y:
			var coordinate = Vector2(x, y)
			var corridors = grid[x][y]
			var key = _create_key_from_corridors(corridors)
			var possible_rooms = room_map[key]
			var room = possible_rooms.pick_random()
			var instance = room.instantiate()
			instance.position = room_size * coordinate
			add_child(instance)


func _create_key(top, bottom, left, right):
	return ("T" if top else "") +\
		("B" if bottom else "") +\
		("L" if left else "") +\
		("R" if right else "")


func _create_key_from_room(room):
	return _create_key(room.top, room.bottom, room.left, room.right)


func _create_key_from_corridors(corridors):
	return _create_key(corridors.has(Vector2.UP), corridors.has(Vector2.DOWN),
		corridors.has(Vector2.LEFT), corridors.has(Vector2.RIGHT))


func _recursive_backtracking(grid, coordinate):
	var directions = [ Vector2.UP, Vector2.LEFT, Vector2.DOWN, Vector2.RIGHT ]
	# directions = directions.filter(func(direction): not grid[coordinate.x][coordinate.y].has(direction))
	directions.shuffle()
	
	for direction in directions:
		var next = coordinate + direction
		
		# Skip impossible tiles
		if next.x < 0 or next.x >= size.x or\
			next.y < 0 or next.y >= size.y or\
			not grid[next.x][next.y].is_empty():
			continue
		
		print("unlocking corridor between " + str(coordinate) + " and " + str(next))
		
		grid[coordinate.x][coordinate.y].append(direction)
		grid[next.x][next.y].append(-direction)
		grid = _recursive_backtracking(grid, next)
	
	return grid








