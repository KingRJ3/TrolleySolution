@abstract class_name Game extends Node2D
var game_manager: GameManager

##call this signal when your game is done
signal end_game(won : bool)

func _ready() -> void:
	if get_parent() is not GameManager:
		_start_game()
	else:
		game_manager = get_parent()

## automatically plays on scene load, NOTE: do NOT make a ready function if extending this class otherwise this will not work. Treat this as your ready function extension.
@abstract
func _start_game() #this function is automatically called when the scene transitions in

## returns the game intensity if connected to the main game, otherwise returns an intensity of 1.0
func get_intensity() -> float: #returns the intensity
	if game_manager: 
		return game_manager.game_intensity
	else:
		return 1.0 #testing mode
		
