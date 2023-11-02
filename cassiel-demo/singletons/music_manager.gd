extends Node

var bus = "Music"
var player:AudioStreamPlayer

export (Array, Resource) var music_tracks

var shuffled_tracks: = []

func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	player = AudioStreamPlayer.new()
	add_child(player)
	player.bus = bus
	play()
	
	player.connect("finished", self, "on_track_finished")
	

func on_track_finished():
	play()
	
	
func play():
	randomize()
	if shuffled_tracks.size() <= 0:
		shuffled_tracks = music_tracks.duplicate()
		shuffled_tracks.shuffle()
		
		var new_track = shuffled_tracks.pop_back()
		
		if new_track != player.stream:
			player.stream = new_track
		else:
			player.stream = shuffled_tracks.pop_back()
			
		player.play()
	



