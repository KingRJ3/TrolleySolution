class_name ConnorWalstrom 
extends Game

var winstate: bool = true
var gtimer: Timer

# Called when the node enters the scene tree for the first time.
func _start_game():
	$Tyson._setup(get_intensity())
	gtimer = $"Game Timer"
	gtimer.wait_time = 5 / get_intensity()
	await get_tree().create_timer(gtimer.wait_time / 5).timeout
	gtimer.start()
	
	$"Tennis Ball Launcher"._setup(get_intensity())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if !winstate:
		#$"game status".color = Color(1, 0, 0)
		#$"Status text".text = "LOSING!"
	#
	#$timertext.text = "%0.2f" % $"Game Timer".time_left
	return

func _on_game_timer_timeout() -> void:
	end_game.emit(winstate)

func _on_tennis_ball_launcher_launched_ball(ball: TennisBall) -> void:
	# lambdas are fucking awesome
	ball.body_entered.connect(
		func(body: Node) -> void:
			if body == $Tyson/Body:
				winstate = false
			return
	)
	
	return
