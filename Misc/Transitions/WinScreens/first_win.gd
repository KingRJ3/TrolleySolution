extends Transition

@onready var start_point: Marker2D = $StartPoint
@onready var play_point: Marker2D = $PlayPoint
@onready var end_point: Marker2D = $EndPoint

func _start_transition():
	if not is_inside_tree():
		await tree_entered
	new_scene_to_move.global_position = start_point.global_position
	var tween_old = get_tree().create_tween()
	tween_old.tween_property(old_scene_to_move, 'global_position', end_point.global_position, 1.1)
	
	
	
	var tween_new = get_tree().create_tween()
	tween_new.tween_property(new_scene_to_move, 'global_position', play_point.global_position, 1.1)
	await tween_old.finished
	 
	old_scene_to_move.queue_free()
	transition_finished.emit()
