class_name StatContainer
extends HBoxContainer

onready var _icon = $Icon
onready var _value = $Value

export (Resource) var icon
export (String) var key
export var isPercentage = false


func _ready():
	var value_formatted = str(RunData.current_stats[key]) + "%"
	_icon.texture = icon
	if isPercentage:
		_value.text = value_formatted
	else:
		_value.text = str(RunData.current_stats[key] as int)
#	_value.text = str(PlayerStats.effects[key] as int)
#	print(PlayerStats.effects[key])
	# value.text = str(RunData or PlayerStat.effects[key] as int) ???




