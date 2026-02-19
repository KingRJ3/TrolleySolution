class_name Player extends CharacterBody3D

var mouse_sensitivity = 0.002

@onready var camera_3d: Camera3D = $Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var hand: Marker3D = $Hand

@onready var spray: Node3D = $Camera3D/spray
@onready var hold: Marker3D = $Camera3D/Hold
@onready var gone: Marker3D = $Camera3D/Gone
@onready var shoot: Marker3D = $Camera3D/Shoot
@onready var spray_lerp = gone

var started = false

func check_anim():
	$Node2D/CheckPoint/AnimationPlayer.play("checkpoint")

func _physics_process(delta: float) -> void:
	if !started: return
	if Input.is_action_pressed("right_click"):
		if ray_cast_3d.is_colliding():
			var raycast_col = ray_cast_3d.get_collider()
			if raycast_col and raycast_col.has_method("interacting"):
				raycast_col.interacting()
				spray_lerp = shoot
				spray.rotation.y += randf_range(-.05,.05)
	spray.global_position = lerp(spray.global_position, spray_lerp.global_position, delta * 25)
	spray.global_rotation = lerp(spray.global_rotation, spray_lerp.global_rotation, delta * 25)

func interact():
	pass

func _input(event: InputEvent) -> void:
	if !started: return
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera_3d.rotate_x(-event.relative.y * mouse_sensitivity)

func give_spray():
	if ray_cast_3d.is_colliding():
		return ray_cast_3d.get_collision_point() 
func give_normal():
	if ray_cast_3d.is_colliding():
		return ray_cast_3d.get_collision_normal()
