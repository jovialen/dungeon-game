extends State
class_name SummonState


@export var summoner : Node2D
@export var next_state : State
@export var summons := [
	{ "count": 3, "summon": preload("res://Scenes/Entitites/Enemies/goblin.tscn") }
]
@export var range := 5


func start():
	var summon = summons.pick_random()
	
	for i in summon["count"]:
		var instance = summon["summon"].instantiate()
		var player = get_tree().get_first_node_in_group("player")
		var angle_to_player = (player.global_position - summoner.global_position).angle() + PI/2
		instance.position = Vector2(range, 0).rotated(angle_to_player).rotated(randf_range(-30.0, 30.0))
		summoner.add_child(instance)
	
	change_state.emit(next_state)
