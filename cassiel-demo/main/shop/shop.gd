extends Node2D

signal update_item_ui

const item_bought_sfx = preload("res://main/shop/item_bought_sfx.wav")
const item_buy_sfx = preload("res://main/shop/item_buy_sfx.wav")

var player = preload("res://units/player/Player.tscn")
onready var items = $Items
onready var pos1 = $ItemBoxPositions/pos1
onready var pos2 = $ItemBoxPositions/pos2
onready var pos3 = $ItemBoxPositions/pos3


var item_positions = []


onready var player_spawn_point = $PlayerSpawnPoint
var _player = null
var gold_label = null


var _items = []
var _items_full = []

var nb_items = 3

var count = 0


func _ready():
	_items = RunData.shop_items.duplicate()
	randomize()
	_items_full = _items.duplicate()
	_items.shuffle()
	
	
	item_positions = [pos1, pos2, pos3]

	for i in range(0,nb_items):
		generate_items()
	
	get_all_items()
	RunData.wave_ended = false
	RunData.current_wave += 1
	RunData.player_in_shop = true
	_player = player.instance()
	_player.global_position = player_spawn_point.global_position
	add_child(_player)
	gold_label = _player.get_node("UI/MaginContainer/PlayerInfo/UIGold/GoldLabel")

func generate_items():
	if _items.empty():
		_items = _items_full.duplicate()
		_items.shuffle()
	var random_item = _items.pop_front()
	
	var item = random_item.instance()
	item.global_position = item_positions[count].global_position
	items.add_child(item)
	
	count += 1


func get_all_items():
	for i in $Items.get_children():
		i.connect("item_bought", self, "_on_item_bought")


func _on_item_bought(effect, value, isWeapon, price, item_scene, item_name, key, ui_value, decrease_value, effect_to_decrease, effect_ui_to_decrease, ui_decrease_value):
	if price <= RunData.gold:
		gold_label.text = str(RunData.gold - price)
		emit_signal("update_item_ui")
		if isWeapon:
			RunData.weapons.push_back(item_scene)
			remove_item_from_list(item_name)
		else:
			PlayerStats.effects[effect] += value
			PlayerStats.effects[effect_to_decrease] -= decrease_value
			RunData.current_stats[key] += ui_value
			RunData.current_stats[effect_ui_to_decrease] -= ui_decrease_value
			remove_item_from_list(item_name)
		remove_item_from_shop(item_name)
		SoundManager.play(item_bought_sfx)
		SoundManager.play(item_buy_sfx)
		RunData.gold -= price
	else:
		print("you can't buy this item")
		#emit signal to player to update ui 

func remove_item_from_shop(item_name):
	for i in $Items.get_children():
		if i.item_name == item_name:
			i.queue_free()

func remove_item_from_list(item_name):
	var i = 0
	for item in RunData.shop_items:
		if item.instance().item_name == item_name:
			RunData.shop_items.remove(i)
		i += 1

func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://main/chapel/main_chapel.tscn")
	RunData.player_in_shop = false
