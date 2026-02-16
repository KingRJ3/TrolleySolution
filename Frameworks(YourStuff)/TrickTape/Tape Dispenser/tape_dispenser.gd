class_name TapeDispenser extends Node3D

const TAPE = preload("uid://3l6601abffpf")
@onready var tape_location: Marker3D = $TapeLocation
var new_tape : Decal
#@onready var dispenser: Sprite3D = $dispenser
#@onready var tape: Sprite3D = $dispenser/tape
var enabled : bool = false

var package : Package

#func _ready() -> void:
	#look_at(Vector3.ZERO)

#func _physics_process(delta: float) -> void:
	#global_position = lerp(global_position, get_parent().global_position, 2.0 * delta)

func _on_timer_timeout() -> void:
	if package == null || enabled == false:
		return
	new_tape = TAPE.instantiate() as Decal
	tape_location.add_child(new_tape)
	new_tape.global_transform = tape_location.global_transform
	new_tape.reparent(package, true)
	enabled = false
