class_name Spinner extends Node3D
## subdcribe to chopiethecat on youtube c:

const MOUSE_SENSITIVITY : float = 0.002
const COVERAGE_INCREMENT_AMOUNT : float = 0.08

signal package_finished_wrapping

#const PACKAGE = preload("uid://bbnhk1576kmjl")
const BOX = preload("uid://bf8owuegxjcly")
const MIGUEL = preload("uid://b0daissj7v7do")
const SKULL = preload("uid://73odhl4c6k8b")

var packages : Array[PackedScene] = [SKULL, BOX, MIGUEL]
var available_packages = packages.duplicate()
var paused : bool = false
@onready var package_center_target: Marker3D = $PackageCenterTarget
@onready var spawn_location: Marker3D = $SpawnLocation

@export var package : Package
@export var tape_dispenser : TapeDispenser

var coverage : float

func _ready() -> void:
	available_packages.shuffle()
	go_to_next_package()

func pause():
	paused = true
	go_to_next_package()

func _input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion:
		return
	if !Input.is_action_pressed("left_click"):
		return
	
	drag(event)

func drag(event: InputEventMouseMotion):
	if package == null:
		return

	var target_input_dir : Vector2 = Vector2(-tape_dispenser.global_position.x, tape_dispenser.global_position.y)
	var spin_effectiveness : float = target_input_dir.normalized().dot(event.relative.normalized())
	spin_effectiveness = clamp(spin_effectiveness, 0.0, 1.0)
	var spin_power : float = clamp(0, 20,  event.relative.length())
	tape_dispenser.enabled = true
	coverage += COVERAGE_INCREMENT_AMOUNT * spin_effectiveness * spin_power
	package.next_rotation_dir = event.relative
	coverage = clamp(coverage, 0, 100)
	if coverage == 100:
		coverage = 0
		package_finished_wrapping.emit()
		go_to_next_package()

func go_to_next_package():
	delete_old_package(package)
	package = null
	await get_tree().create_timer(0.5).timeout
	if available_packages.is_empty():
		available_packages = packages.duplicate()
		available_packages.shuffle()
	package = available_packages.pop_front().instantiate()
	if paused: return
	add_child(package)
	package.global_position = spawn_location.global_position
	tape_dispenser.package = package

func delete_old_package(old_package : Package):
	if old_package == null:
		return
	old_package.target = null
	await get_tree().create_timer(2.0).timeout
	old_package.queue_free()

func _on_child_entered_tree(node: Node) -> void:
	if node is not Package:
		return
	#print("Setting ", node, "'s target to ", package_center_target)
	node.target = package_center_target
