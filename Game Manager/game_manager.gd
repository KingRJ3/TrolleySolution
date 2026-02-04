extends Node

var time_scale : float = 1.0
const ENGINE_TIME_SCALE_INCREMENT = 0.2
const TEST_1 = preload("uid://bg4eq44cepjio")
const TEST_2 = preload("uid://d1p03ob4ivme1")
const TEST_3 = preload("uid://v2fh4qwgxwaj")

## List of all available games to play
var all_games : Array[PackedScene] = [TEST_1, TEST_2, TEST_3]
## List of games left to play this stage before time scale increases
var games_to_play_this_stage : Array[PackedScene] = all_games.duplicate()
var score : int = 0

func _ready() -> void:
	switch_scene(null)

func _on_game_ended(old_scene : Node, won : bool):
	if won:
		score += 1
	
	if games_to_play_this_stage.is_empty():
		Engine.time_scale += ENGINE_TIME_SCALE_INCREMENT
		games_to_play_this_stage = all_games.duplicate()
	
	switch_scene(old_scene)


func switch_scene(old_scene : Node):
	if old_scene != null:
		old_scene.queue_free()
		await old_scene.tree_exited
	var next_game : PackedScene = games_to_play_this_stage.pick_random()
	games_to_play_this_stage.erase(next_game)
	var new_game : Node = next_game.instantiate()
	
	# ensuring that the next game has necessary signal and method
	if "game_finished" not in new_game:
		printerr("game_finished signal not found in ", new_game)
		switch_scene(null)
		return
	if "start_game" not in new_game:
		printerr("start_game method not found in ", new_game)
		switch_scene(null)
		return
	
	# set up next game
	new_game.game_finished.connect(_on_game_ended)
	add_child.call_deferred(new_game)
	await new_game.ready
	new_game.start_game()
