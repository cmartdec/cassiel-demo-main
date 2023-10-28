extends Button

export(Resource) var focus_entered_sound = preload("res://ui/sounds/button_focus.wav")
export(Resource) var pressed_sound2 = preload("res://ui/sounds/button_pressed2.wav")

func _on_Button_mouse_entered():
	SoundManager.play(focus_entered_sound)

func _on_Button_pressed():
	SoundManager.play(pressed_sound2)
