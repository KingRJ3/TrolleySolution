@abstract class_name TweenEffect extends Node
## The TweenEffect class is an abstract class meant to be used to build out other
## effect classes using tweens. [br]
## This class contains all of the information relating to the tween including
## transitions, easing, and the tween's duration.

## Type of [TransitionType] of the tween.
@export var trans_type : Tween.TransitionType
## Type of [EaseType] of the tween.
@export var ease_type : Tween.EaseType
## Duration of the tween as a [float].
@export var tween_duration : float = 1.0

## The variable holding the tween.
var tween : Tween


## This function resets and creates a new tween with all given parameters:
## [member trans_type], [member ease_type].
func reset_tween():
	# If there is a current tween, abort it
	if tween:
		tween.kill()
	# Create the tween with the [membet ease_type], [member trans_type] and
	# allow for tweening to be done simultaneously
	tween = create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)


@abstract func do_tween() -> void
## This function calls the specific application of the tween, which must be defined
## in any subclass of [TweenEffect].


@abstract func do_tween_from_values() -> void
	## This function takes starting parameters, then call [method do_tween].
	## Parameters this function takes must be individually defined.
