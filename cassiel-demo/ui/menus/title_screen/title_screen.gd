extends Control

onready var _menus = $Menus
onready var attenuate_bg = $AtenuateBackground

func _ready():
	_menus.connect("options_button_pressed", self, "on_options_button_pressed")
	_menus.connect("back_button_pressed", self, "on_back_button_pressed")
	
	
func on_options_button_pressed():
	attenuate_bg.show()
	
func on_back_button_pressed():
	attenuate_bg.hide()
	
