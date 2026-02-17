extends Sprite3D
@onready var tape: Sprite3D = $tape


func _input(event: InputEvent) -> void:
	if !visible:
		decrease_opacity()
		return
	if event is not InputEventMouseMotion:
		decrease_opacity()
		return
	if !Input.is_action_pressed("left_click"):
		decrease_opacity()
		return
	
	increase_opacity()

func increase_opacity():
	tape.modulate.a += 0.2
	tape.modulate.a = clamp(tape.modulate.a, 0, 1)

func decrease_opacity():
	tape.modulate.a -= 0.1
	tape.modulate.a = clamp(tape.modulate.a, 0, 1)


#func _process(_delta: float) -> void:
	#tween.tween_property(tape, "scale", )
