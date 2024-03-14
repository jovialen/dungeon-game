extends Node


@export var level_size := Vector2(2, 2)
@export var level_num := 1

var highscore := 1


func reset():
	highscore = max(level_num, highscore)
	level_size = Vector2(3, 3)
	level_num = 1
