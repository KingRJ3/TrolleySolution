class_name MixerBod extends CharacterBody2D

var mix_state = false
var mix_level = 0.0
var mixing = false
@onready var texture_rect: TextureRect = $"../TextureRect"
@onready var mixing_sfx: AudioStreamPlayer = $MixingSFX
@onready var progressmix: ProgressBar = $"../progressmix"

@onready var game: Node2D = $"../../../.."

signal done_mixing

var clicked = false 
var time_to_stop = 3.0
var timer_rate = false
func interact(pos : Vector2):
	if clicked: return
	clicked = true

func _process(delta: float) -> void:
	if clicked and !mix_state:
		velocity += get_global_mouse_position() - global_position
		rotation += randf_range(-.1,.1)
		if !mixing_sfx.playing:
			mixing_sfx.play()
		progressmix.value = mix_level
		mixing = true
		if mix_level > 3.0:
			velocity.y -= 300.0
			var tweenrot = get_tree().create_tween()
			tweenrot.tween_property($Sprite2D, 'rotation', $Sprite2D.rotation + (2 * PI), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
			mix_state = true
			game.current_paint = texture_rect.get_mix()
			var tween = get_tree().create_tween()
			progressmix.scale = Vector2(.2,1.5)
			tween.tween_property(progressmix, 'scale', Vector2(1,1), 1.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
			emit_signal("done_mixing")
	if mixing and timer_rate:
		mix_level += .1
		timer_rate = false
		mixing = false
	
	rotation = lerp(rotation, 0.0, delta * 2)
	
	velocity.y += 9.8
	move_and_slide()


func _on_timer_timeout() -> void:
	timer_rate = true
