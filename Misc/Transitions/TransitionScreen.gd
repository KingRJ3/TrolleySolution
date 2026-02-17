@abstract class_name Transition extends Node

signal transition_finished

var old_scene_to_move : SubViewportContainer
var new_scene_to_move : SubViewportContainer


func create_casing(game : Game) -> SubViewportContainer:
	var sub_view_port_container = SubViewportContainer.new()
	#add_child.call_deferred(sub_view_port_container)
	var sub_view_port : SubViewport = SubViewport.new()
	sub_view_port.transparent_bg = true
	sub_view_port.size = Vector2(1152, 648)
	sub_view_port_container.add_child.call_deferred(sub_view_port)
	game.reparent(sub_view_port)
	return sub_view_port_container

@abstract
func _start_transition() #this function is automatically called when the scene transitions in

func set_old_scene_to_move(game : Game): #take the current game and GIT it out of here
	old_scene_to_move = await create_casing(game)
	add_child.call_deferred(old_scene_to_move)

func set_new_scene_to_move(game: Game): #instantiate and set position of new scene here, you might want to set the position of where this is
	new_scene_to_move = await create_casing(game)
	add_child.call_deferred(new_scene_to_move)
	new_scene_to_move.global_position.y += 2000 #move it out of here
	await new_scene_to_move.tree_exited
	queue_free() #clears the subviewport when done
	
