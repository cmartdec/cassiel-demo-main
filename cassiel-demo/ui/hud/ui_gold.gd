extends HBoxContainer

onready var gold_label = $GoldLabel

func _ready():
	gold_label.text = str(RunData.gold)
