extends Control

onready var panel_info = $PanelInfo


func _on_Button_mouse_entered():
	panel_info.show()
	
	
func _on_Button_mouse_exited():
	panel_info.hide()
