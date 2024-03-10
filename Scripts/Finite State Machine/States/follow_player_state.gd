extends FollowState
class_name FollowPlayerState


func start():
	if not target:
		target = get_tree().get_nodes_in_group("player")[0]
