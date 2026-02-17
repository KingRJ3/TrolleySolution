class_name Tyson
extends Node2D

@onready var intensity: float = 1.0
@onready var is_setup: bool = false

func _setup(intens: float) -> void:
	self.intensity = intens
	self.is_setup = true
	return

func _physics_process(delta: float) -> void:
	if !is_setup:
		assert(false, "<Tyson::_physics_process> Error: Tyson instance was not set up with Tyson::_setup")
	var lfist: Fist = $"Left Arm/Left Rear Arm/Left Forearm/Left Fist"
	var rfist: Fist = $"Right Arm/Right Rear Arm/Right Forearm/Right Fist"
	
	lfist.queue_set_linear_velocity(
		(get_global_mouse_position() - lfist.global_position)
		.normalized() 
		* TennisBall.base_speed 
		* intensity
	)
	
	rfist.queue_set_linear_velocity(
		(get_global_mouse_position() - rfist.global_position)
		.normalized() 
		* TennisBall.base_speed 
		* intensity
	)

	return
