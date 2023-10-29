extends MarginContainer

export var type: String

signal select_button_pressed

export(Resource) var focus_entered_sound = preload("res://ui/sounds/button_focus.wav")


func _on_SelectButton_pressed():
	if type == "damage":
		PlayerStats.effects["stat_damage"] += PlayerStats.effects["stat_damage"] * 0.1
	if type == "speed":
		PlayerStats.effects["stat_speed"] += PlayerStats.effects["stat_speed"] * 0.2
	emit_signal("select_button_pressed")


func _on_SelectButton_mouse_entered():
	SoundManager.play(focus_entered_sound)
