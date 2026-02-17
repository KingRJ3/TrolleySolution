class_name Fist
extends RigidBody2D

var to_apply: Vector2 = Vector2.ZERO

func do_central_force(force: Vector2) -> void:
	to_apply = force

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.linear_velocity = to_apply
	to_apply = Vector2.ZERO
	
	return
