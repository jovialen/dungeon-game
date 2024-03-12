extends Node


@export var summoner : Node2D
@export var summon_time := 30

@onready var finite_state_machine = $"../.."
@onready var summon_state = $".."

@onready var timer := summon_time + 1

var player


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _process(delta):
	if summoner.global_position.distance_to(player.global_position) > 200:
		return
	
	timer += delta
	if timer > summon_time:
		timer = 0
		finite_state_machine.set_state(summon_state)
