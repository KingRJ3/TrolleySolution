class_name ConnorWalstrom 
extends Game

const sounds := [
	preload("res://Frameworks(YourStuff)/Connor/assets/opening_bell.mp3"),
	preload("res://Frameworks(YourStuff)/Connor/assets/crowd_ooh.mp3"),
	preload("res://Frameworks(YourStuff)/Connor/assets/dragon-studio-crowd-cheer-and-applause-406644.mp3")
]

var winning: bool = true
var gtimer: Timer

# Called when the node enters the scene tree for the first time.
func _start_game():
	$Tyson._setup(get_intensity())
	gtimer = $"Game Timer"
	gtimer.wait_time = 5 / get_intensity()
	
	$"Sound Emitter".stream = sounds[0]
	$"Sound Emitter".pitch_scale *= get_intensity()
	$"Sound Emitter".play()
	await $"Sound Emitter".finished
	gtimer.start()
	
	$"Tennis Ball Launcher"._setup(get_intensity())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if !winning:
		#$"game status".color = Color(1, 0, 0)
		#$"Status text".text = "LOSING!"
	
	#$timertext.text = "%0.2f" % $"Game Timer".time_left
	return

func _on_game_timer_timeout() -> void:
	if winning:
		$"Sound Emitter".stream = sounds[2]
		$"Sound Emitter".play()
	end_game.emit(winning)

func _on_tennis_ball_launcher_launched_ball(ball: TennisBall) -> void:
	# lambdas are fucking awesome
	ball.body_entered.connect(
		func(body: Node) -> void:
			if body == $Tyson && winning:
				winning = false
				$Tyson.die()
				$"Sound Emitter".stream = sounds[1]
				$"Sound Emitter".play()
			return
	)
	
	return
