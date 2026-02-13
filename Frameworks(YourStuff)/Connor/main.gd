class_name ConnorWalstrom 
extends Game

@export var tb_scene: PackedScene
@export var tb_angle: float = 45
var screen_size: Vector2 = Vector2.ZERO
var winstate: bool = true

var btimer: Timer
var gtimer: Timer

# Called when the node enters the scene tree for the first time.
func _start_game():
	btimer = $"Ball Timer"
	gtimer = $"Game Timer"
	screen_size = get_viewport_rect().size
	$Tyson.position = Vector2(screen_size.x / 3, screen_size.y / 2)

	btimer.wait_time = 0.75 / get_intensity()
	gtimer.wait_time = 5 / get_intensity()
	btimer.start()
	gtimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_ball_timer_timeout() -> void:
	var tennis_ball: TennisBall = tb_scene.instantiate()
	
	# TODO: check to see that this vector decomp is correct
	var theta: float = deg_to_rad(randf_range(tb_angle - (tb_angle/2), tb_angle + (tb_angle/2)))
	var xspeed: float = -1 * tennis_ball.base_xspeed * get_intensity() * cos(theta)
	var yspeed: float = -1 * tennis_ball.base_yspeed * get_intensity() * sin(theta)
	
	tennis_ball.position = Vector2(screen_size.x, screen_size.y) # TODO: Replace
	tennis_ball.rotation = randf_range(0, 2 * PI)
	tennis_ball.linear_velocity = Vector2(xspeed, yspeed)
	tennis_ball.angular_velocity = randf_range(0, 2 * PI * get_intensity())
	
	add_child(tennis_ball)
	return


func _on_game_timer_timeout() -> void:
	emit_signal("end_game", winstate)
