extends Game

@onready var adaptive_music: AdaptiveMusic = $AdaptiveMusic
@onready var bass: CheckBox = $Bass
@onready var drum: CheckBox = $Drum
@onready var rhod: CheckBox = $Rhod
@onready var voca: CheckBox = $Voca

##USEFUL FUNCITONS
#start
#stop
#increase_volume(index, volume, how fast the fade is, on what beat) -> use this to adapt

##signals to use
#signal current_beat
#signal current_bar
#signal current_four_bar
#signal current_eight_bar

##USEFUL variables
# var current_beat_index = 0 #current beat during the song


func _process(delta: float) -> void:
	$RichTextLabel.text = '[shake][rainbow]   
			  Current Beat: ' + str(adaptive_music.current_beat_index)
	if Input.is_key_pressed(KEY_1):
		adaptive_music.increase_volume(0, -10.0, .01, 16)
	if Input.is_key_pressed(KEY_2):
		adaptive_music.increase_volume(1, -10.0, .01, 16)
	if Input.is_key_pressed(KEY_3):
		adaptive_music.increase_volume(2, -10.0, .01, 16)
	if Input.is_key_pressed(KEY_4):
		adaptive_music.increase_volume(3, -10.0, .01, 32)
	if Input.is_key_pressed(KEY_5):
		adaptive_music.increase_volume(0, -80.0, .5, 16)
		adaptive_music.increase_volume(1, -80.0, .5, 16)
		adaptive_music.increase_volume(2, -80.0, .5, 16)
		adaptive_music.increase_volume(3, -80.0, .5, 16)
	
	if adaptive_music.tracks[0].volume_db == -10.0:
		bass.button_pressed = true
	if adaptive_music.tracks[1].volume_db == -10:
		drum.button_pressed = true
	if adaptive_music.tracks[2].volume_db == -10:
		rhod.button_pressed = true
	if adaptive_music.tracks[3].volume_db == -10:
		voca.button_pressed = true


func _on_adaptive_music_current_beat() -> void: #beat
	$Small.scale.y *= .5
	$Small/Node2DEffect.do_tween()

func _on_adaptive_music_current_bar() -> void: #4 beats
	$Skinny.scale.y *= .5
	$Skinny/Node2DEffect.do_tween()

func _on_adaptive_music_current_four_bar() -> void: #16 beats
	$Normalwhat.scale.y *= .5
	$Normalwhat/Node2DEffect.do_tween()
	
func _on_adaptive_music_current_eight_bar() -> void: #32 beats
	$Fat.scale.y *= .5
	$Fat/Node2DEffect.do_tween()
