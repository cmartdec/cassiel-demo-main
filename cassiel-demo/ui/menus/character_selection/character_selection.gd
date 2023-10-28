extends Control


func _on_CharacterContainer_pressed():
	get_tree().change_scene(MenuData.map_selection_screen)


func _on_Button_pressed():
	get_tree().change_scene(MenuData.title_screen_scene)


func _on_CharacterContainerNode_set_character_cassiel(key):
	RunData.current_character = key
