extends Node2D

const SHOOT_SFX = preload("res://items/priest_staff/mixkit-fast-magic-game-spell-883.mp3")

export var enemy_targets = []
export (PackedScene) var projectile_scene:PackedScene
export var projectile_speed = 40.0
var should_shoot = true
onready var attack_cooldown = $AttackCooldown
var default_cooldown_time = 1.0

func _ready():
	print(PlayerStats.effects["stat_velocity_attack"])
	attack_cooldown.wait_time = default_cooldown_time * PlayerStats.effects["stat_velocity_attack"]


func _physics_process(delta):
	shoot()

func shoot():
	if enemy_targets.size() > 0:
		if should_shoot:
#				SoundManager.play(SHOOT_SFX)
				SoundManager2D.play(SHOOT_SFX, global_position)
				var projectile = projectile_scene.instance()
				projectile.global_position = global_position
				projectile.target = get_random_target()
				get_tree().get_root().add_child(projectile)
				should_shoot = false
				attack_cooldown.start()
			

func get_random_target():
	var rand_index: int = randi() % enemy_targets.size()
	if enemy_targets.size() > 0:
		return enemy_targets[rand_index].global_position

func _on_AttackCooldown_timeout():
	should_shoot = true

func _on_Area2D_area_entered(area):
	enemy_targets.append(area)

func _on_Area2D_area_exited(area):
	enemy_targets.erase(area)
