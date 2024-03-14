extends Node2D


@export var autoload := true
@export var maze_size := Vector2(2, 2)
@export var tile_size := Vector2(16, 16)
@export var room_size := Vector2(20, 20)
@export var room_enterance := preload("res://Scenes/Rooms/floor_enterance.tscn")
@export var room_exits : Array[PackedScene] = [preload("res://Scenes/Rooms/floor_exit.tscn")]
@export var rooms : Array[PackedScene] = [
	preload("res://Scenes/Rooms/room.tscn")
]


func _ready():
	if autoload:
		maze_size = get_node("/root/LevelData").level_size
	
	var grid = []
	var edges = []
	var room_position = Vector2()
	for x in maze_size.x:
		room_position.x = room_size.x * tile_size.x * x
		grid.append([])
		for y in maze_size.y:
			room_position.y = room_size.y * tile_size.y * y
			var room = rooms.pick_random().instantiate()
			room.position = room_position
			grid[x].append(room)
			add_child(room)
			
			if x > 0: edges.append([x, y, Room.Corridor.LEFT])
			if y > 0: edges.append([x, y, Room.Corridor.TOP])
	
	edges.shuffle()
	var union = _create_union_list(maze_size.x * maze_size.y)
	
	while len(edges) > 0:
		var edge = edges.pop_back()
		var x = edge[0]
		var y = edge[1]
		var dir = edge[2]
		
		var offset = Room.CORRIDOR_OFFSETS[dir]
		var nx = x + offset.x
		var ny = y - offset.y
		
		var i0 = y * maze_size.x + x
		var i1 = ny * maze_size.x + nx
		
		if _are_united(union, i0, i1):
			continue
		union = _unite(union, i0, i1)
		
		var reverse = Room.REVERSE_CORRIDOR[dir]
		
		grid[x][y].set_passage(dir, true)
		grid[nx][ny].set_passage(reverse, true)
	
	room_position = grid[0][0].position
	room_position.y -= room_size.y * tile_size.y
	var enterance = room_enterance.instantiate()
	enterance.position = room_position
	add_child(enterance)
	
	get_tree().get_first_node_in_group("player").position = room_position
	
	grid[0][0].set_passage(Room.Corridor.TOP, true)
	enterance.set_passage(Room.Corridor.BOTTOM, true)
	
	room_position = grid[-1][-1].position
	room_position.y += room_size.y * tile_size.y
	var exit = room_exits.pick_random().instantiate()
	exit.position = room_position
	add_child(exit)
	
	grid[-1][-1].set_passage(Room.Corridor.BOTTOM, true)
	exit.set_passage(Room.Corridor.TOP, true)


func _create_union_list(size: int) -> Array[int]:
	var union : Array[int] = []
	for i in size:
		union.append(i)
	return union


func _are_united(union: Array[int], a: int, b: int) -> bool:
	return _head(union, a) == _head(union, b)


func _unite(union: Array[int], a: int, b: int) -> Array[int]:
	union[_head(union, a)] = _head(union, b)
	return union


func _head(union: Array[int], n: int) -> int:
	var curr = n
	while union[curr] != curr:
		curr = union[curr]
	union[n] = curr
	return curr
