extends Node2D

export(PackedScene) var projectile_scene:PackedScene
onready var attack_cooldown_timer = $AttackCooldown

var should_shoot = true


func _physics_process(delta):
	if !RunData.player_in_shop:
		shoot()

func shoot():
	if should_shoot:
		var projectile = projectile_scene.instance()
		projectile.global_position = global_position
		projectile.apply_impulse(Vector2(0,0), Vector2(rand_range(-20,20), rand_range(-20,20)))
		get_tree().get_root().add_child(projectile)
		should_shoot = false
		attack_cooldown_timer.start()
		

func _on_AttackCooldown_timeout():
	should_shoot = true


