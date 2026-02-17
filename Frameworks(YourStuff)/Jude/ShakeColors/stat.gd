extends Node3D
@onready var player :Player = get_tree().get_first_node_in_group("player")
const YELLOWSPRAYPOINT = preload("res://Frameworks(YourStuff)/Jude/ShakeColors/yellowspraypoint.tscn")
@onready var area_3d: Area3D = $Area3D

var paint_meter = 0
var done = false

var total_needed = 1.0
var can_paint = false

signal graffiti_start(toggle)
signal graffiti_add(amt)
@onready var spray_paint_game: Node2D = $"../../.."


func interacting():
	can_paint = true
	emit_signal("graffiti_add", paint_meter)

var music_started = false
func _on_timer_timeout() -> void:
	if can_paint:
		if can_paint and done == false and music_started == false:
			music_started = true
			#Music.request_new('bosa')
			emit_signal('graffiti_start', true)
		for i in area_3d.get_overlapping_bodies():
			if i.is_in_group('enemy'):
				i.set_chase()
		paint_meter += .1
		if paint_meter > total_needed and done == false:
			done = true
			#Music.request_new('main')
			$sing.play()
			emit_signal('graffiti_start', false)
			spray_paint_game.won = true
			
		var yp = YELLOWSPRAYPOINT.instantiate()
		add_child(yp)
		
		if player != null:
			if yp and player.give_spray():
				yp.global_position = player.give_spray()
				#yp.global_transform.basis.x = player.give_normal()
			
	can_paint = false
