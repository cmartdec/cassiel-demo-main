extends Node

var bus = "Sound"

func play(sound: AudioStream):
	if sound != null:
		var stream = AudioStreamPlayer.new()
		
		stream.stream = sound
		stream.bus = bus
		stream.connect("finished", stream, "queue_free")
		
		add_child(stream)
		stream.play()
		
	

