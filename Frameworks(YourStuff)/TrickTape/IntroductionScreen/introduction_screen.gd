class_name IntroductionScreen extends Control

@onready var background: Sprite2D = $Background
@onready var background_drag_in: Node2DEffect = $Background/DragIn
@onready var background_drag_out: Node2DEffect = $Background/DragOut


@onready var mouse_icon: Sprite2D = $MouseIcon
@onready var mouse_icon_drag_in: Node2DEffect = $MouseIcon/DragIn
@onready var mouse_icon_drag_out: Node2DEffect = $MouseIcon/DragOut


@onready var drag: Sprite2D = $Drag
@onready var drag_drag_in: Node2DEffect = $Drag/DragIn
@onready var drag_drag_out: Node2DEffect = $Drag/DragOut
@onready var drag_player: AnimationPlayer = $DragPlayer

@onready var turn_right: Node2DEffect = $Drag/TurnRight
@onready var turn_left: Node2DEffect = $Drag/TurnLeft

func _ready() -> void:
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	show_introduction()


func show_introduction() -> void:
	drag_player.play("rotate_loop")
	background.show()
	background_drag_in.do_tween_from_values(Vector2(-1000, 0))
	mouse_icon.show()
	mouse_icon_drag_in.do_tween_from_values(Vector2(-1000, 0))
	drag.show()
	drag_drag_in.do_tween_from_values(Vector2(-1000, 200))
	
	await get_tree().create_timer(3.0).timeout
	
	background_drag_out.do_tween()
	mouse_icon_drag_out.do_tween()
	drag_drag_out.do_tween()
	
	await drag_drag_out.tween.finished
	get_tree().paused = false
	drag_player.stop()
	queue_free()
