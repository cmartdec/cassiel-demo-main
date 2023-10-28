class_name MyMenuButtonParent
extends Button

export(Resource) var focus_entered_sound = preload("res://ui/sounds/button_focus.wav")
export(Resource) var pressed_sound = preload("res://ui/sounds/button_pressed.wav")
export(Resource) var pressed_sound2 = preload("res://ui/sounds/button_pressed2.wav")

func on_pressed():
	 SoundManager.play(pressed_sound2)
	
func on_focus_entered():
	print("button focused")
	
func on_mouse_entered():
	SoundManager.play(focus_entered_sound)

