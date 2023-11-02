extends Control


onready var master_slider = $Sliders/Master/MasterSlider
onready var sound_slider = $Sliders/Sound/SoundSlider


func _ready():
	master_slider.set_value(ProgressData.settings.volume.master)
	sound_slider.set_value(ProgressData.settings.volume.sound)

func _on_SoundSlider_value_changed(value):
	ProgressData.settings.volume.sound = value
	set_volume(value, "Sound")

func _on_MasterSlider_value_changed(value):
	ProgressData.settings.volume.master = value
	set_volume(value, "Master")
	
func set_volume(value:float, bus:String):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear2db(value))


func _on_CheckButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_SliderOption_value_changed(value):
	ProgressData.settings.volume.music = value
	set_volume(value, "Music")
