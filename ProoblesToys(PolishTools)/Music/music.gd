extends Node

#these are what you are going to use
signal current_beat
signal current_bar
signal current_four_bar
signal current_eight_bar

@export var song_list : Dictionary[String, AdaptiveMusic]
var last_beat_index: int = 0
var bar_index: int = 0

var current_song : AdaptiveMusic
var level_mind = 0
var level_shop = 1

func the_beg():
	current_song.start()
func stop():current_song.stop()
	
func switch_song(song : String):
	var time_to_start = current_song.master_track.get_playback_position()
	current_song.stop()
	match song:
		"shop":
			current_song = song_list.get('shop')
		"glob":
			current_song = song_list.get('glob')
		"openyourmind":
			current_song = song_list.get('openyourmind')
	current_song.start(time_to_start)

func _process(_delta: float) -> void:
	return
	if !current_song.master_track.playing: return
	var current_beat_index = int(current_song.master_track.get_playback_position() / current_song.beat_duration)
	
	if current_beat_index > last_beat_index or current_beat_index == 0 and last_beat_index > current_beat_index:
		emit_signal("current_beat")
		last_beat_index = current_beat_index
		bar_index += 1
		if bar_index % 4 == 0: emit_signal("current_bar")
		if bar_index % (4 * 4) == 0:emit_signal("current_four_bar")
		if bar_index % (4 * 4 * 2) == 0:emit_signal("current_eight_bar")
