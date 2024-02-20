extends State
class_name ChaseState


@export var parent: CharacterBody2D
@export var chase_speed := 25.0
@export var sight_range := 100.0

var player: CharacterBody2D


func start():
	player = get_tree().get_nodes_in_group("player")[0]


func physics_update(delta):
	if not player:
		wander()
		return
	
	var ab = player.position - parent.position
	var distance = ab.length()
	var direction = ab.normalized()
	
	if distance > sight_range:
		wander()
		return
	
	parent.velocity = direction * chase_speed


func wander():
	emit_signal("change_state", "wander")
