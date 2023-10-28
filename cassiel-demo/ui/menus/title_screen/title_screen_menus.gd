extends Control

signal options_button_pressed
signal back_button_pressed

onready var main_menu = $MainMenu
onready var options_menu = $MenuOptions


func _on_OptionsButton_pressed():
	main_menu.hide()
	options_menu.show()
	emit_signal("options_button_pressed")
	

func _on_Button_pressed():
	main_menu.show()
	options_menu.hide()
	emit_signal("back_button_pressed")


func _on_QuitButton_pressed():
	ProgressData.save()
	get_tree().quit()
