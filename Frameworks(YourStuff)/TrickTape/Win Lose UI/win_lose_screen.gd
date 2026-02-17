class_name WinLoseScreen extends Control

#region win stuff
@onready var win_sprite: Sprite2D = $WinSprite
@onready var win_sprite_effect: Node2DEffect = $WinSprite/StampEffect

@onready var win_background: Sprite2D = $WinBackground
@onready var win_background_effect: Node2DEffect = $WinBackground/StampEffect

@onready var whimsy: Sprite2D = $Whimsy
@onready var stamp_effect: Node2DEffect = $Whimsy/StampEffect
#endregion

#region lose stuff

@onready var lose_sprite: Sprite2D = $LoseSprite
@onready var grow_lose: Node2DEffect = $LoseSprite/Grow


@onready var lose_background: Sprite2D = $LoseBackground
@onready var grow_background: Node2DEffect = $LoseBackground/Grow

@onready var slash_1: Sprite2D = $Slash1
@onready var slash_1_grow: Node2DEffect = $Slash1/Grow

@onready var slash_2: Sprite2D = $Slash2
@onready var slash_2_grow: Node2DEffect = $Slash2/Grow

@onready var slash_3: Sprite2D = $Slash3
@onready var slash_3_grow: Node2DEffect = $Slash3/Grow



#endregion

signal lost_anim_finished
signal win_anim_finished

func won() -> void:
	await get_tree().create_timer(1).timeout
	win_sprite.show()
	win_background.show()
	win_sprite_effect.do_tween_from_values(win_sprite.position, 60, Vector2(7,7))
	win_background_effect.do_tween_from_values(win_sprite.position, 60, Vector2(7,7))
	await win_background_effect.tween.finished
	whimsy.show()
	stamp_effect.do_tween_from_values(whimsy.position, 60, Vector2(10,10))
	await stamp_effect.tween.finished
	
	await get_tree().create_timer(1.0).timeout
	win_anim_finished.emit()


func lost() -> void:
	await get_tree().create_timer(1).timeout
	
	slash_1.show()
	slash_1_grow.do_tween_from_values(Vector2.ZERO, 0, Vector2.ZERO)
	await slash_1_grow.tween.finished
	slash_2.show()
	slash_2_grow.do_tween_from_values(Vector2.ZERO, 0, Vector2.ZERO)
	await slash_2_grow.tween.finished
	slash_3.show()
	slash_3_grow.do_tween_from_values(Vector2.ZERO, 0, Vector2.ZERO)
	await slash_3_grow.tween.finished
	
	await get_tree().create_timer(0.5).timeout
	
	lose_background.show()
	grow_background.do_tween_from_values(Vector2(-500, 0), 0, Vector2.ZERO)
	await grow_background.tween.finished
	lose_sprite.show()
	grow_lose.do_tween_from_values(Vector2.ZERO, 0, Vector2.ZERO)
	
	await grow_lose.tween.finished
	await get_tree().create_timer(1.0).timeout
	lost_anim_finished.emit()
