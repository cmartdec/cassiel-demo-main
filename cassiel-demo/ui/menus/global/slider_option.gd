extends HBoxContainer

signal value_changed(value)

onready var _slider = $HSlider
onready var _value = $Value

func _ready():
	_value.text = str(_slider.value * 100)
	
func set_value(value:float):
	_slider.value = value
	_on_HSlider_value_changed(value)

func _on_HSlider_value_changed(value):
	_value.text = str(value * 100)
	emit_signal("value_changed", value)
