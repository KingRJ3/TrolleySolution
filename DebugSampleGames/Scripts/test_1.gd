extends Node2D

signal game_finished(game_root : Node, won : bool)

func start_game():
	print(name, " started")
	await get_tree().create_timer(2.0).timeout
	game_finished.emit(self, true)
