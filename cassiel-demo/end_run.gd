extends Control

onready var tween = $TransitionPanel/Tween
onready var transition_panel = $TransitionPanel


func _ready():
	tween.interpolate_property(transition_panel, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2)
	tween.start()
	PlayerStats.clean_up()

func _on_Button_pressed():
	RunData.clean_up_stats()
	get_tree().change_scene(MenuData.title_screen_scene)
