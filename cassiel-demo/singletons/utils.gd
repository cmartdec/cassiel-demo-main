extends Node

var physics_fps = ProjectSettings.get("physics/common/physics_fps")

func physics_one(delta:float):
	return physics_fps * delta
	
func get_red_color() -> Color:
	return Color(1.0, 0.0, 0.0)
	
func merge_dictionaries(a, b):
	var c = a.duplicate(true)
	
	for key in b:
		if key in c:
			if a[key] is Dictionary and b[key] is Dictionary:
				c[key] = merge_dictionaries(a[key], b[key])
			else :
				c[key] = b[key]
		else :
			c[key] = b[key]
	
	return c
