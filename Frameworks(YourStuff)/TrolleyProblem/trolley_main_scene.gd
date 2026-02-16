extends Game

var passed_in_counter : float = 1.2 #add function something later
var switch_toggled : bool = false
var win_con_up : int # ranges 0 to 1 (false or true)
var can_click : bool = false

func _start_game():
	win_con_up = randi_range(0,1)
	if win_con_up: # makes more people on top, less on bottom
		$TopVictims/AlivePerson.queue_free()
		$TopVictims/DeadPerson.queue_free()
		$BottomVictims/AliveGroup.queue_free()
		$BottomVictims/DeadGroup.queue_free()
	else:
		$TopVictims/AliveGroup.queue_free()
		$TopVictims/DeadGroup.queue_free()
		$BottomVictims/AlivePerson.queue_free()
		$BottomVictims/DeadPerson.queue_free()

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#win_con_up = randi_range(0,1)
	#if win_con_up: # makes more people on top, less on bottom
		#$TopVictims/AlivePerson.queue_free()
		#$TopVictims/DeadPerson.queue_free()
		#$BottomVictims/AliveGroup.queue_free()
		#$BottomVictims/DeadGroup.queue_free()
	#else:
		#$TopVictims/AliveGroup.queue_free()
		#$TopVictims/DeadGroup.queue_free()
		#$BottomVictims/AlivePerson.queue_free()
		#$BottomVictims/DeadPerson.queue_free()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("space") and can_click:
		switch_toggled = not switch_toggled # toggles whether switch is activated
		$LeverLogic/UpLines.visible = not $LeverLogic/UpLines.visible
		$LeverLogic/StraightLines.visible = not $LeverLogic/UpLines.visible
		$LeverLogic.toggle_lever() #swaps sprites


func _on_fork_body_entered(_body: CharacterBody2D) -> void:
	if switch_toggled: # switch is activated
		$Trolley.is_forked_up = true # it will move on the top path
	# else if not switched nothing changes


func _on_top_victims_body_entered(_body: Node2D) -> void:
	end_game_stuff($TopVictims, true)

func _on_bottom_victims_body_entered(_body: Node2D) -> void:
	end_game_stuff($BottomVictims, false)
	
func end_game_stuff(Victim : Area2D, went_up : bool):
	for children in Victim.get_children():
		children.visible = not children.visible
	if went_up and win_con_up or not went_up and not win_con_up:
		end_game.emit(true)
		$Screams.disable_screams(4)
		$EndGameWait.start()
	else:
		$Screams.disable_screams(1)
		end_game.emit(false)
		$EndGameWait.start()
		


func _on_track_turn_body_entered(_body: Node2D) -> void:
	$Trolley.hit_turn = true
	
func make_spacebar_appear():    
	$SpacebarAsset.visible = true
	can_click = true
	$Screams.enable_screams()


func _on_end_game_wait_timeout() -> void:
	get_tree().reload_current_scene()
