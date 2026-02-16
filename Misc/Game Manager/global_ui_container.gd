class_name GlobalUI extends SubViewportContainer

@onready var lvl_intensity: Label = $GlobalUI/Control/LvlIntensity
@onready var lives: Label = $GlobalUI/Control/Lives
@onready var color_rect: ColorRect = $GlobalUI/ColorRect
@onready var score: Label = $GlobalUI/Control/Score

func set_lvl_intensity(amount : float): lvl_intensity.text = "Current Level Intensity: " + str(amount)
func set_lives(amount : int): lives.text = 'Lives: ' + str(amount)
func set_score(amount : int): score.text = 'Score: ' + str(amount)

func show_win_status(win : bool):
	var tween = get_tree().create_tween()
	if win:
		color_rect.color = Color.GREEN
	else:
		color_rect.color = Color.RED
	
	tween.tween_property(color_rect, 'color:a', 0.0, .5)
