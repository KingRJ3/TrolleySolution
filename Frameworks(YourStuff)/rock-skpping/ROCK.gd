extends RigidBody2D
var skipped : bool = false
var skip_counter : int = 0
var inside_place : bool = false
var timer_handler : bool = false
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@onready var controls: RichTextLabel = $"../Controls"
@onready var splash: AudioStreamPlayer = $Splash
@onready var shadow: Sprite2D = $"../badWater/Shadow"
@onready var wind: AudioStreamPlayer = $"../Wind"
@onready var music: AudioStreamPlayer = $"../Music"
#Idk if I like this music. But it's music lol
@onready var ww_game: Game = $".." as Game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Engine.time_scale = 2
	timer.wait_time = 0.15

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if wind.playing == false:
		wind.play()
	if music.playing == false:
		ww_game.queue_free()
	controls.position.x -= 20 * delta
	if Input.is_action_just_pressed("skip") && inside_place == true:
		skipped = true
		print("skipped")
	else: 
		if Input.is_action_just_pressed("skip") && inside_place == false:
			timer.wait_time +=0.5
	if skip_counter == 3:
		Engine.time_scale = 1.0
		ww_game.end_game.emit(true)
		print("you won!")
		sprite_2d.visible = false
		shadow.visible = false
		skip_counter = 0
	if timer.wait_time >= 3:
		Engine.time_scale = 1.0
		ww_game.end_game.emit(false)
		print("you lost!! Bro you suck at throwing rocks fr")
		sprite_2d.visible = false
		shadow.visible = false
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
		Engine.time_scale = 1.0
		ww_game.end_game.emit(false)
		print("you lost!! Bro you suck at throwing rocks fr")
		sprite_2d.visible = false
		shadow.visible = false
	else:
		splash.play()
	if timer_handler == false:
			timer.wait_time += 0.1
			timer_handler = true

func _on_timer_timeout() -> void:
	if sprite_2d.flip_h == true:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true

#This whole script is full of terrible practices but micro jam so shut up :>
