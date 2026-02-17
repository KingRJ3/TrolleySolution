class_name TennisBallLauncher
extends Node2D

signal launched_ball(ball: TennisBall)

@export var tb_launch: Vector2
@export var tb_scene: PackedScene
@export var tb_angle: float = 35

@export var intensity: float = 1.0
var is_setup: bool = false

var timer: Timer

func _setup(inten: float) -> void:
	self.intensity = inten
	self.tb_launch = $"TB Launch Point".position
	self.is_setup = true
	
	timer = $"Launch Timer"
	timer.wait_time = 1 / self.intensity
	timer.start()
	
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_launch_timer_timeout() -> void:
	assert(self.is_setup, "<TennisBallLauncher::_on_launch_timer_timeout> Error: Object has not been set up with TennisBallLauncher::_setup")
	var tennis_ball: TennisBall = tb_scene.instantiate()
	
	var theta: float = deg_to_rad(randf_range(tb_angle - (tb_angle/2), tb_angle + (tb_angle/2)))
	var xspeed: float = -1 * tennis_ball.base_speed * intensity * cos(theta)
	var yspeed: float = -1 * tennis_ball.base_speed * intensity * sin(theta)
	
	tennis_ball.position = Vector2(tb_launch.x, tb_launch.y)
	tennis_ball.rotation = randf_range(0, 2 * PI)
	tennis_ball.linear_velocity = Vector2(xspeed, yspeed)
	tennis_ball.angular_velocity = randf_range(0, 2 * PI * intensity)
	
	add_child(tennis_ball)
	launched_ball.emit(tennis_ball)
	return
