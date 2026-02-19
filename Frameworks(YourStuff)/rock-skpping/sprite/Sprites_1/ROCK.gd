extends RigidBody2D
var skipped = false
var skip_counter = 0
var inside_place = false
var timer_handler = false
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 0.15

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("skip") && inside_place == true:
		skipped = true
		print("skipped")
	else: 
		if Input.is_action_just_pressed("skip") && inside_place == false:
			timer.wait_time +=0.5
	if skip_counter == 3:
		print("you won!")
		queue_free()
		skip_counter = 0
	if timer.wait_time >= 3:
		print("you lost!! Bro you suck at throwing rocks fr")
		queue_free()
		#end game idk how to lol
func _on_area_2d_body_entered(body: Node2D) -> void:
	inside_place = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	inside_place = false
	skipped = false
	skip_counter += 1
	timer_handler = false


func _on_bad_water_body_entered(body: Node2D) -> void:
	if skipped == false:
		print("you lost!! Bro you suck at throwing rocks fr")
		queue_free()
	if timer_handler == false:
			timer.wait_time += 0.1
			timer_handler = true


func _on_timer_timeout() -> void:
	if sprite_2d.flip_h == true:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true
