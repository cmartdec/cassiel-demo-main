extends Node2D

var thunder_staff_projectile_scene = preload("res://projectiles/thunder_staff_projectile/thunder_staff_projectile.tscn")

onready var cooldown_timer = $Cooldown
onready var _audio = $AudioStreamPlayer2D
var time_before_spawn = 60.0

var should_shoot = true

var thunder_staff_projectile

func _physics_process(delta):
	if !RunData.player_in_shop:
		shoot()

func shoot():
		if should_shoot:
			_audio.play()
			thunder_staff_projectile = thunder_staff_projectile_scene.instance()
			thunder_staff_projectile.global_position = global_position
			get_tree().get_root().add_child(thunder_staff_projectile)
			should_shoot = false
			cooldown_timer.start()
		

func _on_Cooldown_timeout():
	should_shoot = true
