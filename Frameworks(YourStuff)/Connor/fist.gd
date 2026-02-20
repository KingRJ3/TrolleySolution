class_name Fist
extends RigidBody2D

@onready var to_apply: Array[Callable] = []

func queue_set_linear_velocity(linvel: Vector2) -> void:
	to_apply.append(func(state: PhysicsDirectBodyState2D) -> void:
		state.linear_velocity = linvel
		return
	)
	return

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for operation: Callable in to_apply:
		operation.call(state)

	return
