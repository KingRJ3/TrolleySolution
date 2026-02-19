class_name Tyson
extends Node2D

@onready var is_alive: bool = true
@onready var intensity: float = 1.0
@onready var boost: float = 1.5
@onready var is_setup: bool = false

func _setup(intens: float) -> void:
	$".".set_deferred(&"freeze", true)
	self.intensity = intens
	self.is_setup = true
	return

func _physics_process(delta: float) -> void:
	if !is_setup:
		assert(false, "<Tyson::_physics_process> Error: Tyson instance was not set up with Tyson::_setup")
	if !is_alive:
		return
	
	var lfist: Fist = $"Left Arm/Left Rear Arm/Left Forearm/Left Fist"
	var rfist: Fist = $"Right Arm/Right Rear Arm/Right Forearm/Right Fist"
	var speed_boost: float = TennisBall.base_speed * intensity * boost
	lfist.queue_set_linear_velocity(
		(get_global_mouse_position() - lfist.global_position)
		.normalized()
		* speed_boost
	)
	
	rfist.queue_set_linear_velocity(
		(get_global_mouse_position() - rfist.global_position)
		.normalized()
		* speed_boost
	)

	return

func die() -> void:
	is_alive = false
	$"Left Arm/Left Rear Arm/Left Forearm/Left Fist".queue_set_linear_velocity(Vector2.ZERO)
	$"Right Arm/Right Rear Arm/Right Forearm/Right Fist".queue_set_linear_velocity(Vector2.ZERO)
	$".".set_deferred(&"freeze", false)
	
	return


func _offscreen() -> void:
	queue_free()
