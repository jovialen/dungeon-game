extends State
class_name MonitoringState


@export var watcher : Node2D = null
@export var watching_groups : Array[String] = []
@export var sight := 20
@export var next_state : State = null

var watching : Array[Node2D] = []


func start():
	watching.clear()
	for group in watching_groups:
		watching.append_array(get_tree().get_nodes_in_group(group))


func _process(delta):
	if not watcher or not next_state:
		return
	
	for node in watching:
		if node is Node2D:
			var distance = (node.global_position - watcher.global_position).length()
			if distance <= sight:
				change_state.emit(next_state)
