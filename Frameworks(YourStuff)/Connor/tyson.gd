class_name Tyson
extends Node2D

const _default_spring_vals: Dictionary[String, float] = {
	"llength": 240,
	"lrest": 240,
	"lxpos": -7,
	"lypos": -98,
	"lrotdeg": 250,

	"rlength": 182,
	"rrest": 182,
	"rxpos": -11,
	"rypos": -59,
	"rrotdeg": -99.5,
	
	"stiff": 64,
	"damp": 16,
	"bias": 0.9
}

@export var base_punch_timer: float = 0.5
@export var intensity: float = 1.0

@onready var mouse_pos: Vector2 = Vector2.ZERO
@onready var is_setup: bool = false

func valdif(a: float, b: float) -> float:
	return abs(a - b) / abs((a + b) / 2)

func _setup(intens: float) -> void:
	self.intensity = intens
	self.is_setup = true
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup(1.0)
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#return
#
func _physics_process(delta: float) -> void:
	var lfist: Fist = $"Left Arm/Left Rear Arm/Left Forearm/Left Fist"
	var rfist: Fist = $"Right Arm/Right Rear Arm/Right Forearm/Right Fist"
	
	lfist.do_central_force((get_global_mouse_position() - lfist.position).normalized() * )
	rfist.do_central_force((get_global_mouse_position() - rfist.position).normalized() * )
	
	if Input.is_action_just_pressed(&"left_click") and $"Left Arm/Punch Timer".time_left <= 0:
		$"Left Arm/Punch Timer".start()
		var spring: DampedSpringJoint2D = $"Left Arm/Body-Fist Spring"
		spring.length *= 3
		spring.rest_length *= 3
		lfist.apply_central_impulse((get_global_mouse_position() - lfist.global_position).normalized())
		
		await get_tree().create_timer(base_punch_timer).timeout
		spring.length = _default_spring_vals.llength
		spring.rest_length = _default_spring_vals.lrest
		
	if Input.is_action_just_pressed(&"right_click") and $"Right Arm/Punch Timer".time_left <= 0:
		$"Right Arm/Punch Timer".start()
		var spring: DampedSpringJoint2D = $"Right Arm/Body-Fist Spring"
		spring.length *= 3
		spring.rest_length *= 3
		await get_tree().create_timer(base_punch_timer).timeout
		spring.length = _default_spring_vals.rlength
		spring.rest_length = _default_spring_vals.rrest
	
	# Yeah yeah, duplicated code. Whatever
	
	return

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_pos = event.position
	return
