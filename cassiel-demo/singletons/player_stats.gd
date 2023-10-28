extends Node

#var base_health = 15.0
export var effects: Dictionary = {"stat_health": 15.0, "stat_speed": 90.0, "stat_armor": 1, "stat_damage": 1, "stat_crit_chance": 0, "stat_velocity_attack": 1, "stat_shoot_speed": 1, "null": 0}


#percentage: stat_speed, stat_damage, stat_crit_chance, stat_velocity_attack, stat_shot_speed
#non pecentage: stat_health, stat_armor

export var health:int

func clean_up():
	effects = {"stat_health": 15.0, "stat_speed": 90.0, "stat_armor": 1, "stat_damage": 1, "stat_crit_chance": 0, "stat_velocity_attack": 1, "stat_shoot_speed": 1, "null": 0}
	


