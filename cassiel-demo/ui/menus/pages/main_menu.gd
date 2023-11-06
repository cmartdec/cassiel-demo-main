extends Control


func _on_StartButton_pressed():
	get_tree().change_scene(MenuData.character_selection_scene)
