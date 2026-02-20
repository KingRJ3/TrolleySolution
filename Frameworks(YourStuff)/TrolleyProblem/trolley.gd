extends CharacterBody2D

@onready var game: Node2D = $".."

var timer_done : bool = false
var is_forked_up : bool = false
var hit_turn : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.start.connect(start)
	#$Timer.wait_time = get_parent().passed_in_counter
	#$Timer.start()
func start():
	$Timer.wait_time = get_parent().passed_in_counter
	$Timer.start()
func _physics_process(_delta: float) -> void:
	if timer_done and not is_forked_up:
		velocity.x = 2400
		velocity.y = 875
	elif hit_turn:
		velocity.x = 2400
		velocity.y = 600
	elif is_forked_up:
		velocity.x = 2450
		velocity.y = -875
	move_and_slide()
	
	


func _on_timer_timeout() -> void:
	timer_done = true
