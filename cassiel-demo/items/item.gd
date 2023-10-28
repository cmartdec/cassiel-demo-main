extends Node2D


signal item_bought(item_scene, price)

onready var animation_player = $AnimationPlayer
onready var price_label = $ItemFloatingText/Price
onready var item_name_label = $ItemFloatingText/VBoxContainer2/ItemName
onready var item_description_label = $ItemFloatingText/VBoxContainer2/Description
onready var item_decrease_description_label = $ItemFloatingText/VBoxContainer2/DecreaseDescription
onready var floating_text = $ItemFloatingText

export var item_scene: PackedScene 
export var effect: String
export var effect_to_decrease: String
export var effect_ui_to_decrease: String
export var value: float
export var decrease_value: float
export var ui_decrease_value: float
export var isWeapon: bool
export var price: int
export var item_name: String
export var description: String

export var key: String
export var ui_value: int

var root_owner = null

func _ready():
	root_owner = get_parent().get_parent()
	root_owner.connect("update_item_ui", self ,"_on_update_item_ui")
	floating_text.visible = false
	animation_player.play("floating")
	price_label.text = str(price)
	item_name_label.text = item_name
	item_description_label.text = description
	if isWeapon:
		item_decrease_description_label.text = "WEAPON"
		item_decrease_description_label.modulate = "ffffff"
	if RunData.gold < price:
		price_label.self_modulate = Color.red

func _on_ShowItemData_area_entered(area):
	if area.is_in_group("buy"):
		floating_text.visible = true

func _on_update_item_ui():
#	print("hello")
	if RunData.gold < price:
		price_label.self_modulate = Color.red
		

func _on_ShowItemData_area_exited(area):
	if area.is_in_group("buy"):
		floating_text.visible = false

func _on_BuyArea_area_entered(area):
	if area.is_in_group("buy"):
		emit_signal("item_bought", effect, value, isWeapon, price, item_scene, item_name, key, ui_value, decrease_value, effect_to_decrease, effect_ui_to_decrease, ui_decrease_value)
#		print(price)
#		if RunData.gold >= price:
#			print("to remove item")
#			queue_free()
		#particle system

