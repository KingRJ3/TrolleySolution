extends Node
class_name Spring
#note this is a simplified version of a spring, they are ussualy better ways to do this, but I cant find my other spring code
##ANOTHER NOTE, you can just place this script in a generic node and it should work
#region IGNORE THIS STUFF

@export var value := 0.0 #current value
@export var goal := 0.0 #where the spring resets to
@export var tension := 300.0 #strength of spring
@export var damping := 20.0 #how fast the spring slows down

var vel := .01

func _process(delta: float) -> void:
	spring(delta)
	
func spring(delta): 
	var displacement = value - goal
	var force = -tension * displacement - damping * vel
	vel += force * delta
	value += vel * delta
	
#endregion

func set_value(val): value = val #use this to set the spring value
func get_value(): return value #use this to read the spring value
