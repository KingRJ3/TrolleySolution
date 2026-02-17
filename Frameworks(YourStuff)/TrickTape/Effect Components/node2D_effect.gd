class_name Node2DEffect extends TweenEffect
## [Node2DEffect] is an extension of [TweenEffect] and additionally contains
## position, rotation, and scale parameters.

## The node which will have the effect applied.
@export var affected_node : Node2D

## The position the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged
@export var position_amount : Vector2 = Vector2.INF
## The rotation amount is the rotation degrees the tween will end at. [br]
## Has INF value by default, and will ignore this parameter if unchanged.
@export var rotation_amount : float = INF
## The scale amount is the scale the tween will end at. [br]
## Has INF values by default, and will ignore individual x or y if left unchanged
@export var scale_amount : Vector2 = Vector2.INF



func do_tween() -> void:
	# Return if there is no node
	if !affected_node:
		printerr(self, "No node assigned to Node2D Effect")
		return
	
	# Create a new tween with given parameters
	reset_tween()
	
	# Tween the positions if not default
	if position_amount.x != INF:
		tween.tween_property(affected_node, "position:x", position_amount.x, tween_duration)
	if position_amount.y != INF:
		tween.tween_property(affected_node, "position:y", position_amount.y, tween_duration)
	
	# Tween the rotation if not default
	if rotation_amount != INF:
		tween.tween_property(affected_node, "rotation_degrees", rotation_amount, tween_duration)
	
	#Tween the scale if not default
	if scale_amount.x != INF:
		tween.tween_property(affected_node, "scale:x", scale_amount.x, tween_duration)
	if scale_amount.y != INF:
		tween.tween_property(affected_node, "scale:y", scale_amount.y, tween_duration)
	


## Takes in a [param start_position], [param start_rotation], and [param start_scale]
## which will be set as startings value before the tween. [br]
## If left unchanged will default to current values in node.
func do_tween_from_values(start_position : Vector2 = affected_node.position, start_rotation : float = affected_node.rotation_degrees, start_scale : Vector2 = affected_node.scale) -> void:
	affected_node.position = start_position
	affected_node.rotation_degrees = start_rotation
	affected_node.scale = start_scale
	
	do_tween()
