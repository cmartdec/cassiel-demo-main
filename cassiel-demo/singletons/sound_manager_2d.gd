extends Node

var bus = "Sound"

func play(sound: AudioStream, pos: Vector2, volume_db: float = 0.0, pitch_scale = 1.0):
		if sound != null:
			var stream = AudioStreamPlayer2D.new()
			
			stream.stream = sound
			stream.volume_db = volume_db
			stream.pitch_scale = pitch_scale
			stream.global_position = pos
			stream.bus = bus
			stream.connect("finished", stream, "queue_free")
			
			add_child(stream)
			stream.play()



