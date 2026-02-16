class_name BouncyCharacter extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") #980
var stand_threshold = 100
@export var bounce := .8

@onready var babyboo_sprite = $Sprite2D

func _physics_process(delta):
#region JUNK you dont have to care abouts
	if not is_on_floor():
		velocity.y += gravity * delta
	if get_last_slide_collision():
		velocity += get_last_slide_collision().get_normal() * (bounce * get_real_velocity().length())
		velocity = lerp(velocity, Vector2.ZERO, delta * 3)
	if !get_floor_normal():
		var forward_rotation = atan2(get_real_velocity().y, get_real_velocity().x) - PI/2
	if get_real_velocity().length() >= stand_threshold:
		babyboo_sprite.rotation = lerp_angle(babyboo_sprite.rotation, atan2(get_real_velocity().y, get_real_velocity().x) - PI/2, 25*delta)
	else:
		babyboo_sprite.rotation = lerp_angle(babyboo_sprite.rotation, 0, 12*delta)
	
	babyboo_sprite.scale.x = lerp(babyboo_sprite.scale.x, 1.0, delta * 8)
	babyboo_sprite.scale.y = lerp(babyboo_sprite.scale.y, 1.0, delta * 2)
	
	move_and_slide()
#endregion

func hurt(direction): #damage percent is just a whole number that 
	velocity += direction
	babyboo_sprite.scale.y = 1.5
	babyboo_sprite.scale.x = .5
