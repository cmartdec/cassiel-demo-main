extends Node


export var current_wave = 1
export var duration_wave = 3
export var player_health:float
export var priest_speed = 90.0
export var wave_ended = false
export var gold = 100
export var player_in_shop = false
#export var wave_enemies_group = []
export var delay_spawn_time = 0.8
export var item_with_crit_chances = false
export var weapons = []
export var shop_items = []
#player stats

export var current_stats = {"max_hp": 0, "speed": 0, "armor": 0, "damage": 0, "crit_chance": 0, "shot_speed": 0, "velocity_attack": 0, "null": 0}

export var items = []

export var dev_mode = false


#export var damage = 0.5
# damage implemented?? - item that give you 50% more damage


func clean_up_stats():
	current_stats = {"max_hp": 0, "speed": 0, "armor": 0, "damage": 0, "crit_chance": 0, "shot_speed": 0, "velocity_attack": 0, "null": 0}
