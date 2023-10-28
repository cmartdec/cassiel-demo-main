extends Control

func _on_MapContainer_pressed():
	get_tree().change_scene(MenuData.main_scene)


func _on_Button_pressed():
	get_tree().change_scene(MenuData.character_selection_scene)
