extends Button

onready var preview = $TextureRect

func _on_MapContainer_mouse_entered():
	preview.show()


func _on_MapContainer_mouse_exited():
	preview.hide()
