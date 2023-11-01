extends Node2D

onready var attack_timer = $AttackCooldown

export var SHOOT:AudioStreamSample

export var enemy_targets = []


var should_shoot = true

var default_wait_time = 1.0

export (PackedScene) var projectile_scene:PackedScene

func _ready():
	attack_timer.wait_time = default_wait_time * PlayerStats.effects["stat_velocity_attack"] 

func _physics_process(delta):
	shoot()

func shoot():
	if enemy_targets.size() > 0:
		if should_shoot:
			var random_pitch = rand_range(0.8, 1.1)
			SoundManager2D.play(SHOOT, global_position, 0.0, random_pitch)
			var projectile = projectile_scene.instance()
			projectile.global_position = global_position
			projectile.target = get_random_target()
			get_tree().get_root().add_child(projectile)
			should_shoot = false
			attack_timer.start()
			
			
			

func get_random_target():
	var rand_index: int = randi() % enemy_targets.size()
	if enemy_targets.size() > 0:
		return enemy_targets[rand_index].global_position


func _on_Area2D_area_entered(area):
	enemy_targets.append(area)


func _on_Area2D_area_exited(area):
	enemy_targets.erase(area)


func _on_AttackCooldown_timeout():
	should_shoot = true
