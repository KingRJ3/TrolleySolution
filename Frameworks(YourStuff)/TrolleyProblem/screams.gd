extends Node2D

var scream_wavs : Array[AudioStreamPlayer]

func disable_screams(num_of_victims : int) -> void:
	scream_wavs.shuffle()
	for i in num_of_victims:
		scream_wavs[i].playing = false

func enable_screams() -> void:
	for child in get_children():
		child.playing = true
		scream_wavs.append(child)

func _on_ahhhhh_finished() -> void:
	$Ahhhhh.playing = true


func _on_ahhh_hhhh_finished() -> void:
	$AhhhHhhh.playing = true


func _on_ahhhhh_h_hh_finished() -> void:
	$AhhhhhHHh.playing = true


func _on_ahh_hhhh_hhh_finished() -> void:
	$AhhHhhhHhh.playing = true


func _on_ahhhhhhhhhh_finished() -> void:
	$Ahhhhhhhhhh.playing = true
