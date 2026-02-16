class_name ConnorWalstrom 
extends Game

var screen_size: Vector2 = Vector2.ZERO
var winstate: bool = true
var gtimer: Timer

# Called when the node enters the scene tree for the first time.
func _start_game():
	gtimer = $"Game Timer"
	screen_size = get_viewport_rect().size

	gtimer.wait_time = 5 / get_intensity()
	gtimer.start()
	
	$"Tennis Ball Launcher"._setup(get_intensity())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_timer_timeout() -> void:
	emit_signal("end_game", winstate)
