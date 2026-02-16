extends Node3D

@onready var coverage_bar: Control = $CoverageBar as Control
@onready var spinner: Spinner = $Spinner as Spinner
@onready var timer: TextureProgressBar = $Timer
@onready var tape_dispenser_positioner: Node3D = $TapeDispenserPositioner

var wrapped_packages_num : int = 0

signal game_was_lost
signal game_was_won

func _ready() -> void:
	game_was_lost.connect(spinner.pause)
	game_was_won.connect(spinner.pause)
	coverage_bar.spinner = spinner
	spinner.package_finished_wrapping.connect(_on_package_finished_wrapping)
	timer.player_died.connect(_on_player_died)
	spinner.package_finished_wrapping.connect(tape_dispenser_positioner.set_new_dispenser_location)

func _on_player_died():
	game_was_lost.emit()
	print('player died')

func _on_package_finished_wrapping():
	wrapped_packages_num += 1
	timer.start()
	if wrapped_packages_num == 3:
		game_was_won.emit()
		timer.pause()
		# TODO: Connect to framework to cycle to next screen
		print('win game')
		#game_was_won.emit()
		#get_tree().quit()
