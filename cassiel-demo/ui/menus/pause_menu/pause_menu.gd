extends Control

onready var pause_menu = $Menu
onready var options_menu = $MenuOptions


func _input(event):
	
	if(event.is_action_pressed("ui_pause")):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_OptionsButton_pressed():
	pause_menu.hide()
	options_menu.show()


func _on_Button_pressed():
	pause_menu.show()
	options_menu.hide()


func _on_ReturnMainMenuButton_pressed():
	get_tree().change_scene(MenuData.title_screen_scene)
	get_tree().paused = false


func _on_ResumeButton_pressed():
	print("hello")
	get_tree().paused = false
	visible = false
