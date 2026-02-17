class_name GameManager extends Node

@onready var start_point: Marker2D = $StartPoint
@onready var play_point: Marker2D = $PlayPoint
@onready var end_point: Marker2D = $EndPoint
#@onready var global_ui_container: GlobalUI = $GlobalUIContainer
@onready var global_ui_container: GlobalUI = $Control
@onready var transition_manager: Node = $TransitionManager

var game_intensity : float = 1.0
const ENGINE_SPEED_INCREASE = 0.2

const TRANS_TIME = 1.0
## List of all available games to play
const BASEPLATE = preload("res://Frameworks(YourStuff)/BasePlate/Baseplate.tscn")
const VANDALISM_JUDE_ = preload("res://Frameworks(YourStuff)/Jude/ShakeColors/Vandalism(Jude).tscn")
const TRICK_TAPE = preload("res://Frameworks(YourStuff)/TrickTape/Main/game_main.tscn")
const ROCK_SKIP = preload("res://Frameworks(YourStuff)/rock-skpping/ww_game.tscn")

var all_games : Array[PackedScene] = [BASEPLATE, VANDALISM_JUDE_]#, TRICK_TAPE]
## List of games left to play this stage before time scale increases
var games_to_play_this_stage : Array[PackedScene]
var score : int = 0
var lives = 3

@onready var old_scene : Game = $TransitionManager/SubViewportContainer/SubViewport/Game
var new_scene = null

func _ready() -> void:
#region Loader of files in Games folder

	#var path = "res://Games(DragPlayableGamesHere)/"
	#var dir_access := DirAccess.open(path)
	#
	#dir_access.list_dir_begin()
	#var file_name := dir_access.get_next()
	#while file_name != "":
		#if not dir_access.current_is_dir() and file_name.get_extension() == "tscn":
			#var full_path := path.path_join(file_name)
			#
			#var scene: PackedScene = load(full_path)
			#if scene:
				#all_games.append(scene)
		#file_name = dir_access.get_next()
		#dir_access.list_dir_end()
	#games_to_play_this_stage = all_games.duplicate()
#endregion
	games_to_play_this_stage = all_games.duplicate()
	switch_scene(true) ##TODO make a start scene
	global_ui_container.set_lives(lives)

func _on_game_ended(won : bool):
	if won:
		score += 1
	#else:
		#lives -= 1
		#if lives <= 0:
			#get_tree().quit() #TODO
		#global_ui_container.set_lives(lives)
	
	global_ui_container.show_win_status(won)
	global_ui_container.set_score(score)
	
	if games_to_play_this_stage.is_empty():
		game_intensity += ENGINE_SPEED_INCREASE
		global_ui_container.set_lvl_intensity(game_intensity)
		games_to_play_this_stage = all_games.duplicate()
	
	switch_scene(won)

func switch_scene(won: bool):
	var next_game : PackedScene = games_to_play_this_stage.pick_random()
	games_to_play_this_stage.erase(next_game)
	var new_game : Game = next_game.instantiate()
	add_child.call_deferred(new_game)
	
	await new_game.ready
	new_scene = new_game
	new_game.end_game.connect(_on_game_ended)
	transition_manager.transition(old_scene, new_game, won)

func _on_transition_manager_transition_finished() -> void:
	new_scene._start_game()
	old_scene = new_scene
