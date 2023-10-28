extends Node2D

const puke_ball_sfx = preload("res://items/puke_ball/puke_ball_sfx.wav")

var puke_ball_projectile_scene = preload("res://projectiles/puke_ball_projectile.tscn")
onready var attack_cooldown = $AttackCooldown

export var default_wait_time = 4.0

var should_shoot = true

func _ready():
	attack_cooldown.wait_time = default_wait_time * PlayerStats.effects["stat_velocity_attack"]


func _physics_process(delta):
	if !RunData.wave_ended and !RunData.player_in_shop:
		shoot(delta)

func shoot(delta):
	if should_shoot:
		var random_pitch = rand_range(0.8, 1.2)
		SoundManager2D.play(puke_ball_sfx, global_position, -4.0, random_pitch)
		var destination1 = generate_random_destination()
		var destination2 = generate_random_destination()
		
		var puke_ball_projectile1 = puke_ball_projectile_scene.instance()
		puke_ball_projectile1.global_position = global_position
		puke_ball_projectile1.target = destination1
		get_tree().get_root().add_child(puke_ball_projectile1)
		
		var puke_ball_projectile2 = puke_ball_projectile_scene.instance()
		puke_ball_projectile2.global_position = global_position
		puke_ball_projectile2.target = destination2
		get_tree().get_root().add_child(puke_ball_projectile2)
		
		should_shoot = false
		attack_cooldown.start()
		
func generate_random_destination():
	var x = rand_range(37, 670)
	var y = rand_range(27, 510)
	return Vector2(x,y)


func _on_AttackCooldown_timeout():
	should_shoot = true

