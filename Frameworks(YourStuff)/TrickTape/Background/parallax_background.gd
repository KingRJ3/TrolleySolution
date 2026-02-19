extends Parallax2D

@onready var good_background: Sprite2D = $GoodBackground

@onready var evil_background: Sprite2D = $EvilBackground

func lost_game() -> void:
	var tweenie : Tween = get_tree().create_tween()
	tweenie.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tweenie.tween_property(evil_background, "modulate", Color.WHITE, 1.0)
