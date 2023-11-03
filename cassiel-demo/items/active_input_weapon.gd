extends Node2D

export (PackedScene) var projectile_scene:PackedScene
onready var attack_timer = $AttackCooldown

const shot_sfx = preload("res://items/royal_cross/swish.wav")

var should_shoot = true

export var default_wait_time = 0.8

func _ready():
	attack_timer.wait_time = default_wait_time * PlayerStats.effects["stat_velocity_attack"]

func _physics_process(delta):
	if !RunData.wave_ended and !RunData.player_in_shop:
		shoot()
		
func shoot():
	if should_shoot:
		SoundManager.play(shot_sfx)
		var projectile = projectile_scene.instance()
		projectile.global_position = global_position
		projectile.target = get_random_target()
		get_tree().get_root().add_child(projectile)
		should_shoot = false
		attack_timer.start()

func get_random_target():
	var x = rand_range(0, 700)
	var y = rand_range(0, 500)
	return Vector2(x,y)


func _on_AttackCooldown_timeout():
	should_shoot = true
