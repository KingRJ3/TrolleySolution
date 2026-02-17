extends Area2D

func _process(delta: float) -> void:
	for i in get_overlapping_bodies():
		if i != null:
			if i.has_method('hover'):
				i.hover()
