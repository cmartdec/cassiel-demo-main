class_name FloatingText
extends Label

onready var _tween = $Tween as Tween

export  var direction: = Vector2(0, - 20)
export  var spread = PI / 4


func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		display("24", 0.5)


func display(content: String, duration: float):
	text = content 
	var movement: = direction.rotated(rand_range( - spread / 2, spread / 2))
	
	
	_tween.interpolate_property(
		self, 
		"rect_position", 
		rect_position, 
		rect_position + movement, 
		duration, 
		Tween.TRANS_ELASTIC, 
		Tween.EASE_OUT
	)
	
	_tween.start()
	yield (_tween, "tween_all_completed")
	
	_tween.interpolate_property(
		self, 
		"rect_scale", 
		Vector2.ONE, 
		Vector2.ZERO, 
		duration, 
		Tween.TRANS_ELASTIC, 
		Tween.EASE_IN_OUT
	)
	
	_tween.interpolate_property(
		self, 
		"modulate:a", 
		1.0, 
		0.0, 
		duration, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT
	)
	
	_tween.start()
	yield (_tween, "tween_all_completed")
	queue_free()

