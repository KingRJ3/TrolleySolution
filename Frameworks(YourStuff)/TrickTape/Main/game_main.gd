extends Game

#@onready var parallax_background: Parallax2D = $Background/ParallaxBackground
#@onready var main: Node3D = $SubViewportContainer/SubViewport/Main
#@onready var win_lose_screen: WinLoseScreen = $"Win_Lose Screen"
#@onready var blood_1: Sprite2D = $Blood/TopBlood/Blood1
#@onready var blood_2: Sprite2D = $Blood/BottomBlood/Blood2

@onready var main: Node3D = $Node/SubViewportContainer/SubViewport/Main
@onready var parallax_background: Parallax2D = $Node/Background/ParallaxBackground

@onready var win_lose_screen: WinLoseScreen = $"Node/Win_Lose Screen"
@onready var blood_1: Sprite2D = $Node/Blood/TopBlood/Blood1
@onready var blood_2: Sprite2D = $Node/Blood/BottomBlood/Blood2

func _start_game():
	main.game_was_lost.connect(lost_game)
	main.game_was_won.connect(won_game)
	Input.set_custom_mouse_cursor(load("res://Frameworks(YourStuff)/TrickTape/Cursor/carrot cursor.png"))


#func _ready() -> void:
	#main.game_was_lost.connect(lost_game)
	#main.game_was_won.connect(won_game)
	#Input.set_custom_mouse_cursor(load("res://Cursor/carrot cursor.png"))


func lost_game() -> void:
	win_lose_screen.lost()
	
	
	parallax_background.lost_game()
	
	var tweenie : Tween = get_tree().create_tween()
	tweenie.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tweenie.tween_property(blood_1, "modulate", Color.WHITE, 1.0)
	tweenie.tween_property(blood_2, "modulate", Color.WHITE, 1.0)
	await win_lose_screen.lost_anim_finished
	await get_tree().create_timer(1.5).timeout
	get_tree().paused = true
	Input.set_custom_mouse_cursor(null)
	print('move on to next game')
	end_game.emit(false)
	get_tree().paused = false


func won_game() -> void:
	win_lose_screen.won()
	await get_tree().create_timer(1.5).timeout
	get_tree().paused = true
	await win_lose_screen.win_anim_finished
	Input.set_custom_mouse_cursor(null)
	print('move on to next game')
	end_game.emit(true)
	get_tree().paused = false
