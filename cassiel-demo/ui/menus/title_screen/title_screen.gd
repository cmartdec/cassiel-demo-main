extends Control

onready var _menus = $Menus
onready var attenuate_bg = $AtenuateBackground

func _ready():
	_menus.connect("options_button_pressed", self, "on_options_button_pressed")
	_menus.connect("back_button_pressed", self, "on_back_button_pressed")
	_menus.connect("credits_button_pressed", self, "on_credits_button_pressed")
	_menus.connect("credits_back_button_pressed", self, "on_credits_back_button_pressed")
	
	
	
func on_options_button_pressed():
	attenuate_bg.show()
	
func on_back_button_pressed():
	attenuate_bg.hide()
	
func on_credits_button_pressed():
	attenuate_bg.show()
	
func on_credits_back_button_pressed():
	attenuate_bg.hide()
